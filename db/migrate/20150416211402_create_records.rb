class CreateRecords < ActiveRecord::Migration
  def change
    create_table(:records) do |t|
      t.float :amount
      t.float :high
      t.references :user, index: true

      t.timestamps
    end
  end
end
