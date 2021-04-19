class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :resource_type
      t.string :action
      t.string :origin
      t.string :cause
      t.string :description
      t.string :event_id
      t.string :source

      t.timestamps
    end
  end
end
