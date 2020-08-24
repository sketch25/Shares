class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comgoods, dependent: :destroy
  has_many :comgood_users, through: :comgoods, source: :user
  has_many :combads, dependent: :destroy
  has_many :combad_users, through: :combads, source: :user

  validates :content, presence: true
end
