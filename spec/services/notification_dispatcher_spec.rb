require "rails_helper"

RSpec.describe NotificationDispatcher do
  it "sendet eine Nachricht über den übergebenen Kanal" do
    channel = double("NotificationChannel")
    dispatcher = NotificationDispatcher.new(
      notification_channel: channel
    )

    expect(channel).to receive(:send_message)

    dispatcher.call
  end
end