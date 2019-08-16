class AddVisitIdToLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :visit_id, :bigint
  end
end
