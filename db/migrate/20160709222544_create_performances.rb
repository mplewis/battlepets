class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.float :score
      t.references :match_id
      t.references :pet_id

      t.timestamps null: false
    end
  end
end
