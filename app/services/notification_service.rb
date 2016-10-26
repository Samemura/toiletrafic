class NotificationService
  def initialize(booth)
    @booth = booth
  end

  def send
    case @booth.state
    when "vacant" then
      msg = "#{@booth.id}のトイレが空きました！"
    when "occupied" then
      msg = "#{@booth.id}のトイレが使用されました！"
    end
    send_to_android(msg)
    send_to_ios(msg)
  end

  def send_to_android(msg)
    app = Rpush::Gcm::App.find_by_name("android")

    Rpush::Gcm::Notification.create!(
      app: app,
      registration_ids: Token.android.tokens,
      data: { message: msg },
      priority: 'high'        # Optional, can be either 'normal' or 'high'
    )
  end

  def send_to_ios(msg)
    app = Rpush::Apns::App.find_by_name("ios")

    ActiveRecord::Base.transaction do
      Token.ios.tokens.each do |t|
        Rpush::Apns::Notification.create!(
          app: app,
          device_token: t,
          alert: msg
        )
      end
    end
  end
end
