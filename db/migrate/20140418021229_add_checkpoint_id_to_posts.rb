class AddCheckpointIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :checkpoint_id, :integer
  end
end
