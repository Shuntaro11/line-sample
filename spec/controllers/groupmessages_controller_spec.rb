require 'rails_helper'

describe GroupmessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#index' do

    context 'ログインしている場合' do
      before do
        login user
        get :index, params: { group_id: group.id }
      end

      it '@groupmessageという変数が正しく定義されている' do
        expect(assigns(:groupmessage)).to be_a_new(Groupmessage)
      end

      it '@groupという変数が正しく定義されている' do
        expect(assigns(:group)).to eq group
      end

      it 'indexビューに遷移する' do
        expect(response).to render_template :index
      end
    end

    context 'ログインしていない場合' do
      before do
        get :index, params: { group_id: group.id }
      end

      it 'ログイン画面に遷移する' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  
  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, groupmessage: attributes_for(:groupmessage) } }

    context 'ログインしている場合' do
      before do
        login user
      end

      context '保存に成功した場合' do
        subject {
          post :create,
          params: params
        }

        it 'メッセージの保存ができる' do
          expect{ subject }.to change(Groupmessage, :count).by(1)
        end

        it 'indexビューに遷移している' do
          subject
          expect(response).to redirect_to(group_groupmessages_path(group))
        end
      end

      context '保存に失敗した場合' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, groupmessage: attributes_for(:groupmessage, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'メッセージの保存は行われない' do
          expect{ subject }.not_to change(Groupmessage, :count)
        end

        it 'indexビューに遷移している' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'ログインしていない場合' do

      it 'ログイン画面に遷移する' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end