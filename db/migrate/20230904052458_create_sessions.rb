class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
    	t.string  :title
    	t.string :type_of_session
      t.timestamps
    end
  end
end
