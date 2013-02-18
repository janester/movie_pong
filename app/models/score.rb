# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  computer   :string(255)
#  player     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Score < ActiveRecord::Base
  attr_accessible :computer, :player
end
