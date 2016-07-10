class AddCompletionStatusToPerformance < ActiveRecord::Migration
  def change
    add_column :performances, :complete, :boolean, default: false
  end
end
