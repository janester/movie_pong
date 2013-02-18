class CreateSaidMoviesTable < ActiveRecord::Migration
  def change
    create_table :said_movies do |t|
      t.string :title
      t.string :year
      t.integer :tmdb_id
      t.timestamps
    end

  end

end
