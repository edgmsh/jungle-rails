class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  # Ensure email is stored in lowercase
  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
  
end
