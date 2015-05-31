class AddReferenceFromToolsToRecords < ActiveRecord::Migration
  def change
    add_reference :records, :tool, index: true
  end
end
