class CreateBoothLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :booth_logs do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration_secs

      t.references :booth

      t.timestamps
    end
  end
end
