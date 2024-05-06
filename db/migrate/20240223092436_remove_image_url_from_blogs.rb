class RemoveImageUrlFromBlogs < ActiveRecord::Migration[7.1]
  def change
    remove_column :blogs, :image_url, :string
  end
end
