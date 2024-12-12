class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents

  def line_items(order_id)
    @line_items = LineItem.where("order_id = ?", order_id)
  end  
  helper_method :line_items

  def product_name(product_id)
    @product = Product.where("id = ?", product_id).pick(:name)
  end
  helper_method :product_name

  def products_now
    @products_now = Product.count
  end
  helper_method :products_now

  def categories_now
    @categories_now = Category.count
  end
  helper_method :categories_now

  def order_email(order_id)
    @order_email = Order.where("id = ?", order_id).pick(:email)
  end
  helper_method :order_email

  def total_line_items(order_id)
    @total_line_items = LineItem.where("order_id = ?", order_id).sum(:total_price_cents)
  end  
  helper_method :total_line_items


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end
end
