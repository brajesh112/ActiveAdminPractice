class RenameActiveToStatusOfPost < ActiveRecord::Migration[7.0]
  def change
  	rename_column :posts, :active, :status
  end
end
