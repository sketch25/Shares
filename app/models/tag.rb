class Tag < ApplicationRecord
  has_many :post_tags , dependent: :destroy
  has_many :posts, through: :posts_tags

  validates :name, presence: true, length: { maximum: 50 }
end
