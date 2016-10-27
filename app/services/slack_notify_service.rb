class SlackNotifyService
  DEFAULT_URL =  ENV['SLACK_WEBHOOK_URL']
  DEFAULT_OPTIONS = {
    link_names: true # this is for mention
  }

  def initialize(url=nil, **options)
    @notifier = Slack::Notifier.new(
      url || DEFAULT_URL,
      DEFAULT_OPTIONS.merge(options)
    )
  end

  def send(msg, mention: nil)
    mtn_str = "@#{mention}\n" if mention
    @notifier&.ping(mtn_str.to_s + msg)
  end
end
