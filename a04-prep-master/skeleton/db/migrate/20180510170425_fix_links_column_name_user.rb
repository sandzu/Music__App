class FixLinksColumnNameUser < ActiveRecord::Migration[5.1]
  def change
    rename_column :links, :user_id, :user 
  end
end
