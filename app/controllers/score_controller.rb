class ScoreController < ApplicationController
  def score
    $player = Score.sum(:player)
    $computer = Score.sum(:computer)
    case $player
    when 1 then $player = "P"
    when 2 then $player = "PO"
    when 3 then $player = "PON"
    when 4 then redirect_to(lose)
    end
    case $computer
    when 1 then $computer = "P"
    when 2 then $computer = "PO"
    when 3 then $computer = "PON"
    when 4 then redirect_to(win)
    end
  end

end
