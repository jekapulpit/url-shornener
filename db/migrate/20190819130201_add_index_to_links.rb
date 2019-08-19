class AddIndexToLinks < ActiveRecord::Migration[5.2]
  def change
    add_index(:links, :link_hash)
    add_index(:links, :original_link)
  end
end
