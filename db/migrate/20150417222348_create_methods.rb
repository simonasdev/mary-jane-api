class CreateMethods < ActiveRecord::Migration
  def change
    create_table :methods do |t|
      t.string :name
      t.text :comment

      t.timestamps null: false
    end
  end
end
