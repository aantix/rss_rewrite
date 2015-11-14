class CreateRsses < ActiveRecord::Migration
  def change
    create_table :rsses do |t|
      t.string :name
      t.string :description
      t.string :uid
      t.string :url

      t.timestamps null: false
    end
  end
end
