class CreateStartMoviesTable < ActiveRecord::Migration
  def change
    create_table :start_movies do |t|
      t.string :title
      t.string :year
      t.integer :tmdb_id
      t.timestamps
    end
  end

end
