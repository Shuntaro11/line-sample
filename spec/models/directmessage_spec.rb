require 'rails_helper'

RSpec.describe Directmessage, type: :model do
  describe '#create' do
    context '保存できる' do
      it 'メッセージがあれば保存できる' do
        expect(build(:directmessage, image: nil)).to be_valid
      end

      it '画像があれば保存できる' do
        expect(build(:directmessage, content: nil)).to be_valid
      end

      it 'メッセージと画像があれば保存できる' do
        expect(build(:directmessage)).to be_valid
      end
    end

    context '保存できない' do
      it 'メッセージも画像も無いと保存できない' do
        directmessage = build(:directmessage, content: nil, image: nil)
        directmessage.valid?
        expect(directmessage.errors[:content]).to include("を入力してください")
      end

      it 'friend_idが無いと保存できない' do
        directmessage = build(:directmessage, friend_id: nil)
        directmessage.valid?
        expect(directmessage.errors[:friend]).to include("を入力してください")
      end

      it 'user_idが無いと保存できない' do
        directmessage = build(:directmessage, user_id: nil)
        directmessage.valid?
        expect(directmessage.errors[:user]).to include("を入力してください")
      end
    end
  end
end