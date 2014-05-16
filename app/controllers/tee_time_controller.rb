class TeeTimeController < ApplicationController


  def times

    @tee_times = TeeTime.where(course_id: current_user.courses.collect(&:id))
  end
end
