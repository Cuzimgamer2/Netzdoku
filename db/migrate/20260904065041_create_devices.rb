class CreateDevices < ActiveRecord::Migration[8.1]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :ip_adress
      t.references :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
