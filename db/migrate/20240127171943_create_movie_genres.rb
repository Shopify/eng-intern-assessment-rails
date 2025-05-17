class CreateMovieGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_genres do |t|
      t.string :name

      t.timestamps
    end
  end
end
