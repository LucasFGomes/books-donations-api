class User < ApplicationRecord
  require 'securerandom'
  
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 3 },
            if: -> { new_record? || !password.nil? }

  has_many :books

  has_one :donation, class_name: 'Donation', foreign_key: :receiver_id
  belongs_to :city
end
