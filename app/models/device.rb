class Device < ApplicationRecord
  belongs_to :contract
  def show_routing_table
    "nicht verfügbar"
  end
end


