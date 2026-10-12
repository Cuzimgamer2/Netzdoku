class CreateContracts < ActiveRecord::Migration[8.1]
  def change
    create_table :contracts do |t|
      t.string :name
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
