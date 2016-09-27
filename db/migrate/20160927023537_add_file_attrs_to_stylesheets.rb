class AddFileAttrsToStylesheets < ActiveRecord::Migration[5.0]
  def change
    add_column :stylesheets, :data, :binary
  end
end
