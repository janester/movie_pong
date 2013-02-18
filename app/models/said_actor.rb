# == Schema Information
#
# Table name: said_actors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SaidActor < ActiveRecord::Base
  attr_accessible :name
end
