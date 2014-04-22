class RemoveCheckpointsAndAddFieldsToPosts < ActiveRecord::Migration
  def change
    drop_table :checkpoints
    add_column :posts, :stayed_clean, :boolean
  end
end
