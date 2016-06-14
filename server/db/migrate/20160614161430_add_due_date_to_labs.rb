class AddDueDateToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :due_date, :datetime
  end
end
