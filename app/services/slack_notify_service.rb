class SlackNotifyService
  DEFAULT_URL =  ENV['SLACK_WEBHOOK_URL']
  DEFAULT_OPTIONS = {
    link_names: true # this is for mention
  }

  def initialize(url=nil, **options)
    u = url || DEFAULT_URL
    @notifier = Slack::Notifier.new(
      u,
      DEFAULT_OPTIONS.merge(options)
    ) if u
  end

  def send(msg, mention: nil)
    mtn_str = "@#{mention}\n" if mention
    @notifier&.ping(mtn_str.to_s + msg)
  end
end
