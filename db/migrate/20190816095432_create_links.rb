class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links, id: false do |t|
      t.string :link_hash, primary: true
      t.string :original_link, null: false
      t.timestamps
    end
  end
end
