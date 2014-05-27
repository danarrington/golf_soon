class TeeTimeController < ApplicationController


  def times
    filter = TeeTimeFilter.new(params[:tee_time_filter])
    filter.user = current_user
    @tee_times = TeeTime.get_times(filter)
    @filter = filter
  end
end


