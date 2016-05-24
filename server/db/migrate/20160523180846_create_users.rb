class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :multipass_id
      t.string :code_path

      t.timestamps null: false
    end
  end
end
