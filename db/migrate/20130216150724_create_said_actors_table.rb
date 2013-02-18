class CreateSaidActorsTable < ActiveRecord::Migration
  def change
    create_table :said_actors do |t|
      t.string :name
      t.timestamps
    end

  end

end
