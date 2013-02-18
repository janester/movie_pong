class CreateSaidMoviesTable < ActiveRecord::Migration
  def change
    create_table :said_movies do |t|
      t.string :title
      t.string :year
      t.timestamps
    end

  end

end
