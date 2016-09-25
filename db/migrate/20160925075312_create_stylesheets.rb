class CreateStylesheets < ActiveRecord::Migration[5.0]
  def change
    create_table :stylesheets do |t|
      t.string :url

      t.timestamps
    end
  end
end