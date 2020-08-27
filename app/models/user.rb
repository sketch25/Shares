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
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  
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
  def self.likes_count(posts)
    likes_count = 0
    posts.each do |post|
      likes_count += post.likes.count
    end
    return likes_count
  end
  def self.bads_count(posts)
    bads_count = 0
    posts.each do |post|
      bads_count += post.bads.count
    end
    return bads_count
  end
  def self.comgoods_count(comments)
    comgoods_count = 0
    comments.each do |comment|
      comgoods_count += comment.comgoods.count
    end
    return comgoods_count
  end
  def self.combads_count(comments)
    combads_count = 0
    comments.each do |comment|
      combads_count += comment.combads.count
    end
    return combads_count
  end
  def self.evaluate_user(likes_count, bads_count, comgoods_count, combads_count)
    if likes_count + bads_count + comgoods_count + combads_count == 0
      return "none"
    else
      evaluate = (likes_count + comgoods_count) * 100 / (likes_count + bads_count + comgoods_count + combads_count)
      case evaluate
      when 0..9 then
        return 0.to_f
      when 10..19 then
        return 0.5.to_f
      when 20..29 then
        return 1.0.to_f
      when 30..39 then
        return 1.5.to_f
      when 40..49 then
        return 2.0.to_f
      when 50..59 then
        return 2.5.to_f
      when 60..69 then
        return 3.0.to_f
      when 70..79 then
        return 3.5.to_f
      when 80..89 then
        return 4.0.to_f
      when 90..99 then
        return 4.5.to_f
      else
        return 5.0.to_f
      end
    end
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end
