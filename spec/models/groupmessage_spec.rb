require 'rails_helper'

RSpec.describe Groupmessage, type: :model do
  describe '#create' do
    context '保存できる' do
      it 'メッセージがあれば保存できる' do
        expect(build(:groupmessage, image: nil)).to be_valid
      end

      it '画像があれば保存できる' do
        expect(build(:groupmessage, content: nil)).to be_valid
      end

      it 'メッセージと画像があれば保存できる' do
        expect(build(:groupmessage)).to be_valid
      end
    end

    context '保存できない' do
      it 'メッセージも画像も無いと保存できない' do
        groupmessage = build(:groupmessage, content: nil, image: nil)
        groupmessage.valid?
        expect(groupmessage.errors[:content]).to include("を入力してください")
      end

      it 'group_idが無いと保存できない' do
        groupmessage = build(:groupmessage, group_id: nil)
        groupmessage.valid?
        expect(groupmessage.errors[:group]).to include("を入力してください")
      end

      it 'user_idが無いと保存できない' do
        groupmessage = build(:groupmessage, user_id: nil)
        groupmessage.valid?
        expect(groupmessage.errors[:user]).to include("を入力してください")
      end
    end
  end
end