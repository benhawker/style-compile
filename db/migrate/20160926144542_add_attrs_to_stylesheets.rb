class AddAttrsToStylesheets < ActiveRecord::Migration[5.0]
  def change
    add_column :stylesheets, :error_message, :string
  end
end

