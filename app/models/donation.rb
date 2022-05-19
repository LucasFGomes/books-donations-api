class Donation < ApplicationRecord
  has_one :book
  has_one :receiver, class_name: 'User', foreign_key: :receiver_id
end
