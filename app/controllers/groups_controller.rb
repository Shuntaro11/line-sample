class GroupsController < ApplicationController
  def new
    @users = current_user.all_following.unshift(current_user)
    @group = Group.new
    @group.users << current_user
  end

  def show
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_groupmessages_path(@group.id), notice: 'グループを作成しました'
    else
      flash.now[:alert] = 'グループを作成できませんでした'
      render :new
    end
  end

  def edit
    @users = current_user.all_following.unshift(current_user)
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_groupmessages_path(@group.id), notice: 'グループを更新しました'
    else
      flash.now[:alert] = 'グループを更新できませんでした'
      render :edit
    end
  end

  def destroy
    @group = Group.find_by(id: params[:id])
    @group.destroy
    redirect_to root_path, notice: 'グループを削除しました'
  end

  private

  def group_params
    params.require(:group).permit(:name, :image, user_ids: [])
  end
end
