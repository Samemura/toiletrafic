class CreateBooths < ActiveRecord::Migration[5.0]
  def change
    create_table :booths do |t|
      t.integer :state

      t.timestamps
    end
  end
end
