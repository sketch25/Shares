require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context 'can save' do

      it "is valid with a name, nickname, email, password, password_confirmation" do
        expect(build(:user)).to be_valid
      end
      
      it "is valid with a name that has less than 16 characters " do
        user = build(:user, name: "aaaaaaaaaaaaaaaa")
        expect(user).to be_valid
      end
      
      it "is valid with a nickname that has less than 8 characters " do
        user = build(:user, nickname: "aaaaaaaa")
        expect(user).to be_valid
      end

      it "is invalid without a icon" do
        user = build(:user, icon: nil)
        expect(build(:user)).to be_valid
      end

      it "is invalid without a profile" do
        user = build(:user, profile: nil)
        expect(build(:user)).to be_valid
      end

      it "is valid with a password that has more than 8 characters " do
        user = build(:user, password: "00000000", password_confirmation: "00000000")
        expect(user).to be_valid
      end

    end

    context 'can not save' do

      it "is invalid without a name" do
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "is invalid without a nickname" do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end
      

      it "is invalid without a email" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
      
      it "is invalid without a password" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "is invalid without a password_confirmation although with a password" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      it "is invalid with a name that has more than 17 characters " do
        user = build(:user, name: "aaaaaaaaaaaaaaaaa")
        user.valid?
        expect(user.errors[:name]).to include("は16文字以内で入力してください")
      end
      

      it "is invalid with a nickname that has more than 9 characters " do
        user = build(:user, nickname: "aaaaaaaaa")
        user.valid?
        expect(user.errors[:nickname]).to include("は8文字以内で入力してください")
      end

      it "is invalid with a duplicate email address" do
        user = create(:user)
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end

      it "is invalid with a password that has less than 7 characters " do
        user = build(:user, password: "00000", password_confirmation: "00000")
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end
  end
end