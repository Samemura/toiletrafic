class InsertPushNotificationAndroidApp < ActiveRecord::Migration[5.0]
  def change
    Rpush::Gcm::App.create!(
      name: "android",
      auth_key: 'AIzaSyAw0xXmVfW_65dririOTUtXjC7Hfz9RIOY',
      connections: 1
    )
  end
end
