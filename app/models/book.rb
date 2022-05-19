class Book < ApplicationRecord
  has_many :pictures
  
  belongs_to :donor, class_name: "User", foreign_key: :user_id
  belongs_to :donation
end
