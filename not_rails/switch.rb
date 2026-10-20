require_relative 'network_device'
require_relative 'pingable'
class Switch < NetworkDevice
  attr_reader :port_count
  include Pingable
  def initialize(name, ip_address, status, port_count)
    super(name, ip_address, status)
    @port_count = port_count
  end

  def describe
    "Infos Switch: #{name}, #{ip_address}, #{status}, #{port_count}"
  end
end


switch = Switch.new("mikrotik", "1.1.1.1", "running", 22)
puts switch.describe
puts switch.ping
