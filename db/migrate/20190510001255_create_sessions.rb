class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :title
      t.integer :problems, default: 0
      t.string :hours, default: "00:00:00"
      t.timestamps
    end
  end
end
