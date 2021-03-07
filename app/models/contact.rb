class Contact < ApplicationRecord
  belongs_to :product

  validates :firstname, :lastname, :message, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/
end
