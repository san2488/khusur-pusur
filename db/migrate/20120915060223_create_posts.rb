class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.references :category
      t.references :user

      t.timestamps
    end
  end
end
