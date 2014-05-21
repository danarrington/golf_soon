module SpecifiedTimes
  def saturday_10_am
    Time.zone = "Pacific Time (US & Canada)"
    saturday = Date.commercial(Date.today.year, Date.today.cweek, 6)
    Time.new(saturday.year, saturday.month, saturday.day, 10, 0, 0).in_time_zone('Pacific Time (US & Canada)')
  end
end