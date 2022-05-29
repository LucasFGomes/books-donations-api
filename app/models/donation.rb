class Donation < ApplicationRecord
  belongs_to :book, optional: true
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id, optional: true
end
