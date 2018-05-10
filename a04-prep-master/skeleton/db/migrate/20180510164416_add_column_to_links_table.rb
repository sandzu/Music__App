class AddColumnToLinksTable < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :user_id, :integer, null:false 
  end
end
