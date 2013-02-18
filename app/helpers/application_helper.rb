module ApplicationHelper
  def convert_to_pong(number)
    case number
    when 1 then "P"
    when 2 then "PO"
    when 3 then "PON"
    end
  end
end
