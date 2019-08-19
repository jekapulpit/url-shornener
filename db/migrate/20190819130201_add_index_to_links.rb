class AddIndexToLinks < ActiveRecord::Migration[5.2]
  def change
    add_index(:links, :link_hash)
  end
end
