class CreateAssignmentsAndLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|

      t.timestamps null: false
    end
    create_table :assignments do |t|
      t.text :description
      t.string :test_path
      t.string :spec_path
      t.belongs_to :lab, index: true

      t.timestamps null: false
    end
  end
end
