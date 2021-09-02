class Need < ApplicationRecord
  enum status: {pending: 0, active: 1, expired: 2, rejected: 3}

  has_many :need_category
  has_many :category, through: :need_category

  validates :point_of_contact, :title, :description, :start_time, :end_time, :zip_code, :supporters_needed, :status, presence: true

  before_create do
    self[:status] = 1
  end
end
