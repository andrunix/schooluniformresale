class UserFriendsController < ApplicationController

  def create
    @user_friend = current_user.user_friends.build(friend_id: params[:friend_id])

    if (@user_friend.save)
      flash[:notice] = "Added friend"
      redirect_to root_url
    else
      flash[:notice] = "Unable to add friend"
      redirect_to root_url
    end

  end

end
