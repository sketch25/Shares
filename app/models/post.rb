class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :bads, dependent: :destroy
  has_many :bad_users, through: :bads, source: :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :posts_tags

  validates :title, :content, presence: true
  self.inheritance_column = :_type_disabled
 
end
