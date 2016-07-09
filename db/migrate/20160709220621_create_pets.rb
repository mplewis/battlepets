class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :strength
      t.integer :agility
      t.integer :wit
      t.integer :perception

      t.timestamps null: false
    end
  end
end
