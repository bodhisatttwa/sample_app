class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)

    if @user.follower_mail_notification?
      UserMailer.new_follower_notification(@user, current_user).deliver
    end

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end

  end

end