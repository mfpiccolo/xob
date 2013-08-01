class AddDraggablesToSearches < ActiveRecord::Migration
  def change
    add_column(:searches, :draggables, :text)
  end
end
