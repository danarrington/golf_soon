class DataParser

  def get_latest_times
    doc = get_doc_to_parse
    doc.css('.cubeWrapper').each { |cube| save_time parse_time_cube cube }
  end

  def parse_time_cube(cube)
    course_id = cube.css('.courseName a').first['productid']
    save_course_info get_course_info course_id
  end

  def get_course_info(course_id)
    doc = get_course_doc course_id
  end

  def get_course_doc(course_id)
    Nokogiri::HTML(open("http://www.golfnow.com/CoursePopUp.aspx?facilityid=#{course_id}&dl=false"))
  end

  def save_time(tee_time)
    # code here
  end

  def get_doc_to_parse
    doc = Nokogiri::HTML(open('http://www.golfnow.com/something'))
  end
end