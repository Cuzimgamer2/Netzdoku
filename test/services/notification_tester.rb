require "test_helper"

class NotificationDispatcherTest < ActiveSupport::TestCase
  test "sends an SMS notification" do
    sms = SmsNotification.new
    dispatcher = NotificationDispatcher.new(
      notification_channel: sms
    )

    assert_output(
      "Ihre SMS Benachritigung wurde verschickt\n"
    ) do
      dispatcher.call
    end
  end
end