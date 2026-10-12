require "rails_helper"

RSpec.describe SmsNotification do
  it "sendet eine SMS" do
    expect { SmsNotification.new.send_message }.to output(
      "Ihre SMS Benachritigung wurde verschickt\n"
    ).to_stdout
  end
end