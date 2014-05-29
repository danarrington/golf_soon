class HomeController < ApplicationController

  def index
    if user_signed_in?
      if current_user.courses.any?
        redirect_to times_path
      else
        redirect_to pick_courses_path
      end
    end
  end

  def pick_courses
    @courses = Course.all
    @favorites = current_user.courses.ids
  end

  def pick_courses_submit

    course_ids = params[:course_ids].split(',')
    courses = Course.find(course_ids)
    current_user.courses << courses

    redirect_to times_path
  end
end
