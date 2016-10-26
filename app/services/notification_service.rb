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
  end

  def send_to_android(msg)
    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("android")
    n.registration_ids = Token.android.tokens
    n.data = { message: msg }
    n.priority = 'high'        # Optional, can be either 'normal' or 'high'
    n.save!
  end
end
