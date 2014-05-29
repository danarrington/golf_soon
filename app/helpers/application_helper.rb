module ApplicationHelper
  def pretty_time time
    time.in_time_zone('Pacific Time (US & Canada)').strftime('%l:%M %P %a')
  end
end
