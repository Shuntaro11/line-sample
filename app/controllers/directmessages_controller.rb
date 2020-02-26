class DirectmessagesController < ApplicationController
  before_action :set_friend

  def index
    @directmessage = Directmessage.new
    @directmessages = @friend.directmessages.includes(:user)
  end

  def create
    @directmessage = @friend.directmessages.new(directmessage_params)
    if @directmessage.save
      respond_to do |format|
        format.html { redirect_to friend_directmessages_path(params[:friend_id]) } #テスト用
        format.json
      end
    else
      @directessages = @friend.directmessages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  private

  def directmessage_params
    params.require(:directmessage).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_friend
    @friend = Friend.find(params[:friend_id])
  end
end
