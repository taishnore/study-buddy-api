class ChangeHoursToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :sessions, :hours, :integer
  end
end
