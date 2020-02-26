class GroupmessagesController < ApplicationController
  before_action :set_group

  def index
    @groupmessage = Groupmessage.new
    @groupmessages = @group.groupmessages.includes(:user)
  end

  def create
    @groupmessage = @group.groupmessages.new(groupmessage_params)
    if @groupmessage.save
      respond_to do |format|
        format.html { redirect_to group_groupmessages_path(params[:group_id]) } #テスト用
        format.json
      end
    else
      @groupmessages = @group.groupmessages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  private

  def groupmessage_params
    params.require(:groupmessage).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
