class AddHiddenToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :hidden, :boolean, default: false
  end
end
