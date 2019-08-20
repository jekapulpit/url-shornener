class RemoveUserReference < ActiveRecord::Migration[5.2]
  def change
    remove_reference :ahoy_visits, :user
    remove_reference :ahoy_events, :user
  end
end
