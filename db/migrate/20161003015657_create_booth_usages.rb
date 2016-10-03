class CreateBoothUsages < ActiveRecord::Migration[5.0]
  def change
    create_table :booth_usages do |t|
      t.integer :use_minute

      t.references :booth
      t.timestamps
    end
  end
end
