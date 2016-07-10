class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.float :score
      t.timestamps null: false
    end

    add_reference :performances, :pet, index: true
    add_reference :performances, :match, index: true
  end
end
