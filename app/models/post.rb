class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :good_users, through: :goods, source: :user
  has_many :bads, dependent: :destroy
  has_many :bad_users, through: :bads, source: :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, :content, presence: true
  self.inheritance_column = :_type_disabled
 
  def self.search(search)
    if search != ""
      if search == "質問"
        Post.where(type: 1)
      else
      Post.where('content LIKE(?) or title LIKE(?) or hashtag LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%")
      end
    else
      Post.all
    end
  end

  after_create do
    post = Post.find_by(id: id)
    tags = hashtag.to_s.gsub(/＃/, '#').scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      hash = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << hash
    end
  end

  before_update do
    post = Post.find_by(id: id)
    post.tags.clear
    tags = hashtag.to_s.gsub(/＃/, '#').scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      hash = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << hash
    end
  end
end


