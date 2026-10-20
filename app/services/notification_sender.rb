class NotificationSender
  def initialize(notification_channel:)
    @notification_channel = notification_channel
  end

  def call(message:)
    @notification_channel.send_message(message)
  end
end
