class DataParser

  def get_latest_times
    @known_course_ids = Course.ids
    doc = get_doc_to_parse
    doc.css('.cubeWrapper').each { |cube| save_time parse_time_cube cube }
  end

  def parse_time_cube(cube)
    course_id = cube.css('.courseName a').first['productid'].to_i
    unless @known_course_ids.include?(course_id)
      course = CourseParser.new.get_course_info(course_id)
      course.save!
    end
  end

  def save_time(tee_time)
    # code here
  end

  def get_doc_to_parse
    url = "http://www.golfnow.com/seattle/tee-times/golf-courses/wa---seattle-metro/search?FID=-1&OID=9543&AID=61&SID={01E99287-F7C4-4A11-9828-3A0C5F9499B0}&FDT=3/27/2014%2012:00:00%20AM&TDT=3/27/2014%2012:00:00%20AM&PPN=all"
    doc = Nokogiri::HTML(open('http://www.golfnow.com/something'))
  end
end
