class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true
  validates :profile,    length: { maximum: 500 } 

  mount_uploader :icon, IconUploader
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :bads, dependent: :destroy
  has_many :bad_posts, through: :bads, source: :post
  has_many :comgoods, dependent: :destroy
  has_many :comgood_comments, through: :comgoods, source: :comments
  has_many :combad, dependent: :destroy
  has_many :combad_comments, through: :combads, source: :comments
  
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
  def already_bad?(post)
    self.bads.exists?(post_id: post.id)
  end
  def already_comgood?(comment)
    self.comgoods.exists?(comment_id: comment.id)
  end
  def already_combad?(comment)
    self.combad.exists?(comment_id: comment.id)
  end
  
end
