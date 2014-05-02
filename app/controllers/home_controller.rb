class HomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to pick_courses_path
    end
  end
  def pick_courses
    @courses = Course.all
  end

  def pick_courses_submit

    course_ids = params[:course_ids].split(',')
    courses = Course.find(course_ids)
    current_user.courses << courses

    render text: params[:course_ids].split(',')
  end
end
