class Admin::CategoriesController < ApplicationController
  before_action :authenticate, only: :index

  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to [:admin, :categories], notice: 'Category deleted!'
  end

  private

  def category_params
    params.require(:category).permit(
      :name,
      :created_at,
      :updated_at
    )
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic("Admin Area") do |username, password|
      username == ENV["ADMIN_USERNAME"] && password == ENV["ADMIN_PASSWORD"]
    end
  end

end
