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
    n.registration_ids = ["fvZj6_iC2HM:APA91bGU28hlTLzx8_-edDlHPfvJc6Kziod4820Msz8HfPQMEAf2Ljs9Q9tP3qtLl728IycC_7TX6XpkSqlX5YNwMzAXILimJBh3U9Hykr0SBHIYkqMbg9zTs850Dws0EMhDpasUJgNJ", "fe4Ohizhv-0:APA91bGU5Ji_FaYGojHVfsYOdIVVDKd_uEdArNcYkppqk14RGkeCHhchJXo09JUwpeSDiDLkh8YIHJjvDeVhNIqN1NR2c33AMikRBCrSj6q3Yj5OjVnZXaGgb4AeKlWfdMdWlyTkbguS"]
    n.data = { message: msg }
    n.priority = 'high'        # Optional, can be either 'normal' or 'high'
    n.save!
  end
end
