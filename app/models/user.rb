class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true
  validates :profile,    length: { maximum: 500 } 

  mount_uploader :icon, IconUploader
  has_many :posts
  has_many :comments
  has_many :likes
  
end
