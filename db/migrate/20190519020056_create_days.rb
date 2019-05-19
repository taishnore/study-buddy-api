class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.date :date #can't default to Date.today, gotta do it in the controller method, with validations.
      t.integer :session_id
      t.integer :time_studied, default: 0
      t.integer :problems, default: 0
      t.timestamps
    end
  end
end
