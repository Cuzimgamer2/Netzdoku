class AddStatusToDevices < ActiveRecord::Migration[8.1]
  def change
    add_column :devices, :status, :string,
               default: "waiting", null: false
  end
end
