class User < ApplicationRecord

    validates :email, presence: true,
    uniqueness: { case_sensitive: false},
    length: {maximum: 255},
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, length: {minimum: 8}
    before_validation { email.downcase! }
    
    has_secure_password
end
