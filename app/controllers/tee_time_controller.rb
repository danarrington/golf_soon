class TeeTimeController < ApplicationController


  def times

    @tee_times = TeeTime.get_times({user:current_user})
  end
end
