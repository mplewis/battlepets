class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.float :score
      t.reference :match_id
      t.reference :pet_id

      t.timestamps null: false
    end
  end
end
