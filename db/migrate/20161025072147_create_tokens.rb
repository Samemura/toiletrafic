class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.string :token
      t.string :platform, limit: 191

      t.timestamps

      t.index :platform
    end
  end
end
