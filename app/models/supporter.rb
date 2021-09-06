class Supporter < ApplicationRecord
  belongs_to :need
  has_many :categories, through: :need

end
