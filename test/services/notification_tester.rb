require "test_helper"

class NotificationSenderTest < ActiveSupport::TestCase
  test "sends an SMS notification" do
    sms = SmsNotification.new
    sender = NotificationSender.new(
      notification_channel: sms
    )

    assert_output(
      "Ihre SMS Benachritigung wurde verschickt\n"
    ) do
      sender.call
    end
  end
end
