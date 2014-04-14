class AddImgUrlToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :img, :string
  end
end
