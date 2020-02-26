require 'rails_helper'

describe DirectmessagesController do
  let(:friend) { create(:friend) }
  let(:user) { create(:user) }

  describe '#index' do

    context 'ログインしている場合' do
      before do
        login user
        get :index, params: { friend_id: friend.id }
      end

      it '@directmessageという変数が正しく定義されている' do
        expect(assigns(:directmessage)).to be_a_new(Directmessage)
      end

      it '@friendという変数が正しく定義されている' do
        expect(assigns(:friend)).to eq friend
      end

      it 'indexビューに遷移する' do
        expect(response).to render_template :index
      end
    end

    context 'ログインしていない場合' do
      before do
        get :index, params: { friend_id: friend.id }
      end

      it 'ログイン画面に遷移する' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    let(:params) { { friend_id: friend.id, user_id: user.id, directmessage: attributes_for(:directmessage) } }

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
          expect{ subject }.to change(Directmessage, :count).by(1)
        end

        it 'indexビューに遷移している' do
          subject
          expect(response).to redirect_to(friend_directmessages_path(friend))
        end
      end

      context '保存に失敗した場合' do
        let(:invalid_params) { { friend_id: friend.id, user_id: user.id, directmessage: attributes_for(:directmessage, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'メッセージの保存は行われない' do
          expect{ subject }.not_to change(Directmessage, :count)
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