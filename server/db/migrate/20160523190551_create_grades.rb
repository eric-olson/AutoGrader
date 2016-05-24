class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :score
      t.belongs_to :user, index: true
      t.belongs_to :assignment, index: true

      t.timestamps null: false
    end
  end
end
