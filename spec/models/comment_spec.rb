require 'rails_helper'

RSpec.describe Comment, type: :mldel do
  describe '#create' do
    context 'can save' do
      it 'is valid with content' do
        expect(build(:comment)).to be_valid
      end
    end

    context 'can not save' do
      it 'is invalid without content' do
        comment = build(:comment, content: nil)
        comment.valid?
        expect(comment.errors[:content]).to include("を入力してください")
      end

      it 'is invalid without user_id' do
        comment = build(:comment, user_id: nil)
        comment.valid?
        expect(comment.errors[:user]).to include("を入力してください")
      end
      
      it 'is invalid without post_id' do
        comment = build(:comment, post_id: nil)
        comment.valid?
        expect(comment.errors[:post]).to include("を入力してください")
      end
    end
  end
end