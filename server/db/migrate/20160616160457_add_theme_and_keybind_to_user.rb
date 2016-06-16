class AddThemeAndKeybindToUser < ActiveRecord::Migration
  def change
    add_column :users, :theme, :string, default: "chrome"
    add_column :users, :keybind, :string, default: "ace"
  end
end
