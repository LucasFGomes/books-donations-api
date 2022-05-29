class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :pictures
  
  belongs_to :donor, class_name: "User", foreign_key: :user_id
  has_one :donation
end
