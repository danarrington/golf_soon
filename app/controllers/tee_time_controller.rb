class TeeTimeController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:update]

  def times
    filter = TeeTimeFilter.new(params[:tee_time_filter])
    filter.user = current_user
    @tee_times = TeeTime.get_times(filter)
    @filter = filter
  end

  def update
    DataParser.new.get_latest_times
    render :text=>'ok'
  end

  def noop
    render :text=>'ok'
  end
end


