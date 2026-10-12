module Pingable
  def ping
    puts "====================="
    puts "pinging: #{name}, #{ip_address}"
    "ping erfolgreich"
  end
end