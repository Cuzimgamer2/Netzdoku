class AddStiToDevices < ActiveRecord::Migration[8.1]
  def change
    add_column :devices, :type, :string
    add_column :devices, :routing_table, :text
  end
end
