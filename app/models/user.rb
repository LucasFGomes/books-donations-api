class User < ApplicationRecord
  require 'securerandom'
  
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 3 },
            if: -> { new_record? || !password.nil? }
  validates :password_confirmation, presence: true

  has_many :books

  belongs_to :donation, foreign_key: :receiver_id
  belongs_to :city
end
