require_relative 'network_device'
require_relative 'pingable'
class Router < NetworkDevice
  attr_reader :routing_table
  include Pingable
  def initialize(name, ip_address, status, routing_table)
    (name, ip_address, status)
    @routing_table = routing_table
  end

  def describe
    "infos: #{name}, #{ip_address}, #{status}, #{@routing_table}"
  end
end

router = Router.new("mikrotik", "1.1.1.1", "running", [20, 20])
puts router.describe
puts router.ping