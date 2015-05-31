class AddReferenceFromToolsToRecords < ActiveRecord::Migration
  def change
    add_reference :records, :tools, index: true
  end
end
