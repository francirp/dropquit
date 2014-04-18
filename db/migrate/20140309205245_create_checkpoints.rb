class CreateCheckpoints < ActiveRecord::Migration
  def change
    create_table :checkpoints do |t|
      t.boolean :submitted_roll_call
      t.text :roll_call
      t.boolean :stayed_clean
      t.date :date

      t.timestamps
    end
  end
end
