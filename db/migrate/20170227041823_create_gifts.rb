class CreateGifts < ActiveRecord::Migration[5.0]
  def change
    create_table :gifts do |column|
      column.string :name
      column.string :where_to_buy
      column.string :recipient
      column.string :notes
      column.integer :user_id
    end
  end
end
