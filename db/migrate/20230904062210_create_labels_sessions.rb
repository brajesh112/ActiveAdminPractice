class CreateLabelsSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :labels_sessions do |t|
    	t.references :label
    	t.references :session
      t.timestamps
    end
  end
end
