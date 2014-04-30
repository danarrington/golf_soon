class HomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to pick_courses_path
    end
  end
  def pick_courses
    @courses = Course.all
  end
end
