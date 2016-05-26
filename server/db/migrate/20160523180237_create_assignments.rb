class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.text :description
      t.string :name
      t.belongs_to :lab, index: true

      t.timestamps null: false
    end
  end
end
