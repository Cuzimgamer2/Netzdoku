
require "rails_helper"

RSpec.describe SmsNotification do
  it "sendet eine SMS" do
    expect {
      SmsNotification.new.send_message("SMS-Test")
    }.to output(
      "Ihre SMS-Benachrichtigung wurde verschickt: SMS-Test\n"
    ).to_stdout
  end
end
