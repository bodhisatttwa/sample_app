class AddFollowerMailNotificationFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :follower_mail_notification, :boolean
  end
end
