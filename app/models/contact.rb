# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  firstname  :string
#  lastname   :string
#  email      :string
#  message    :text
#  product_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Contact < ApplicationRecord
  belongs_to :product

  validates :firstname, :lastname, :email, :message, presence: true
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/
end
