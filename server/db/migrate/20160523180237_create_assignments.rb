class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.text :description
      t.string :test_path
      t.string :spec_path

      t.timestamps null: false
    end
  end
end
