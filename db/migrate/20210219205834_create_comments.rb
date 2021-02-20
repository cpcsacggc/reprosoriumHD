class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.timestamps
      t.integer :post_id
    end
  end
end
