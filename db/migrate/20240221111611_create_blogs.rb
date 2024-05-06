class CreateBlogs < ActiveRecord::Migration[7.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.string :image_url
      t.timestamps
    end
  end
end
