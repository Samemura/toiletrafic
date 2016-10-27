class NotificationService
  def initialize(booth)
    @booth = booth
  end

  def send
    case @booth.state
    when "vacant" then
      msg = "トイレ#{@booth.id} が空きました！"
    when "occupied" then
      msg = "トイレ#{@booth.id} が使用されました！"
    end
    send_to_android(msg)
    send_to_ios(msg)
    send_to_slack(msg)
  end

  def send_to_android(msg)
    app = Rpush::Gcm::App.find_by_name("android")

    tokens = Token.android.tokens
    return if tokens.blank?
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

  def send_to_slack(msg)
    status_str = Booth.all.map{|b| "`#{b.id}:" + (b.vacant? ? "🚽" : "💩") + "`" }.join(" ")
    SlackNotifyService.new.send(status_str + "  ----  " + msg)
  end
end
