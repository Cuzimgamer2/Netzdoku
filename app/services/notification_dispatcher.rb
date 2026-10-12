class NotificationDispatcher
  def initialize(notification_channel:)
    @notification_channel = notification_channel
  end

  def call
    @notification_channel.send_message
  end
end