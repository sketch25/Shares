require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with content' do
        expect(build(:post)).to be_valid
      end
    end

    context 'can not save' do
      it 'is invalid without title' do
        post = build(:post, title: nil)
        post.valid?
        expect(post.errors[:title]).to include("を入力してください")
      end

      it 'is invalid without content' do
        post = build(:post, content: nil)
        post.valid?
        expect(post.errors[:content]).to include("を入力してください")
      end

      it 'is invalid without user_id' do
        post = build(:post, user_id: nil)
        post.valid?
        expect(post.errors[:user]).to include("を入力してください")
      end
    end
  end
end