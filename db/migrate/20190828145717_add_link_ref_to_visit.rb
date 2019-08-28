class AddLinkRefToVisit < ActiveRecord::Migration[5.2]
  def change
    add_reference :ahoy_visits, :link, type: :string
    rename_column :ahoy_visits, :link_id, :link_hash
  end
end
