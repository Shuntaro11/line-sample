class FriendsController < ApplicationController
  def create
    friend = Friend.new
    friend.users.push(current_user, User.find(params[:format]))
    if friend.save
      redirect_to friend_directmessages_path(friend)
    else
      render :back
    end
  end

  private
end
