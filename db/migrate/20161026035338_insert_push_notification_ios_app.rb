class InsertPushNotificationIosApp < ActiveRecord::Migration[5.0]
  def change
    Rpush::Apns::App.create!(
      name: "ios",
      certificate: File.read(Rails.root.join("credentials/push.pem")),
      password: "",
      connections: 1,
      environment: "production" # APNs environment.
    )
  end
end
