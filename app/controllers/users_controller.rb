class UsersController < ApplicationController

  def index; end

  def talkindex; end

  def show
    @user = User.find(params[:id])
  end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def search; end

  def search_result
    @user = User.find_by(email: params[:email])
    unless @user
      flash.now[:alert] = 'ユーザーが見つかりませんでした'
      render search_users_path
    end
  end

  def follow
    @user = User.find(params[:user_id])
    if current_user.all_following.include?(@user)
      flash.now[:alert] = 'すでに友だちです'
      render search_users_path
    else
      current_user.follow(@user)
      if request.referer.include?('search')
        redirect_to root_path, notice: '友だちに追加されました！'
      else
        redirect_to :back, notice: '友だちに追加されました！'
      end
    end
  end

  def unfollow
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
    redirect_to root_path, notice: '友だちリストから削除しました'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :content)
  end
end
