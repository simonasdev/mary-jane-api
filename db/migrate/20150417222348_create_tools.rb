class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.text :comment

      t.timestamps null: false
    end
  end
end
