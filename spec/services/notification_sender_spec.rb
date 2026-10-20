require "rails_helper"

RSpec.describe NotificationSender do
  it "sendet eine Nachricht über den übergebenen Kanal" do
    channel = double("NotificationChannel")
    sender = NotificationSender.new(
      notification_channel: channel
    )

    expect(channel).to receive(:send_message)

    sender.call(message: "Testnachricht")
  end
end
