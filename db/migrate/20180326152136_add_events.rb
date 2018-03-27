class AddEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
    end
    add_index :events, :name, unique: true
  end
end
