class Api::DirectmessagesController < ApplicationController
  def index
    friend = Friend.find(params[:friend_id])
    last_message_id = params[:id].to_i
    @messages = friend.directmessages.includes(:user).where('id > ?', last_message_id)
  end
end
