class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :encrypted_password, null: false, default: ""
      t.string :name

      t.timestamps
    end
  end
end
