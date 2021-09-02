class Category < ApplicationRecord

  validates :tag, presence: true
  has_many :need_category
  has_many :need, through: :need_category

end
