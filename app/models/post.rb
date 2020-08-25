class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :bads, dependent: :destroy
  has_many :bad_users, through: :bads, source: :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, :content, presence: true
  self.inheritance_column = :_type_disabled
 
  def self.search(search)
    if search != ""
      Post.where('content LIKE(?) or title LIKE(?) or hashtag LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Post.all
    end
  end

  after_create do
    post = Post.find_by(id: id)
    tags = hashtag.tr('＃', '#').scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      hash = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << hash
    end
  end

  before_update do
    post = Post.find_by(id: id)
    post.tags.clear
    tags = hashtag.tr('＃', '#').scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      hash = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << hash
    end
  end
end


