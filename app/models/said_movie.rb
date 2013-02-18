# == Schema Information
#
# Table name: said_movies
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  year       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SaidMovie < ActiveRecord::Base
  attr_accessible :title, :year, :tmdb_id
end
