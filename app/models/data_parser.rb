class DataParser

  def get_latest_times
    @known_course_ids = Course.ids
    doc = get_doc_to_parse
    date = Date.parse(doc.css('.dayL').first.text)
    doc.css('.cubeWrapper').each { |cube| save_or_update_time parse_time_cube(cube, date) }
  end

  def parse_time_cube(cube, date)
    tee_time = TeeTimeParser.get_tee_time(cube, date)
    save_new_course(tee_time[:course_id]) unless @known_course_ids.include?(tee_time[:course_id])
    tee_time
  end

  def save_new_course(course_id)
    course = CourseParser.new.get_course_info(course_id)
    course.save!
    @known_course_ids << course.gn_id
  end

  def save_or_update_time(tee_time)
    existing_times = TeeTime.where(course_id: tee_time[:course_id], tee_time: tee_time[:tee_time])
    if existing_times.any?
      existing_time = existing_times.first
      existing_time.assign_attributes(tee_time)
      existing_time.save
    else
      TeeTime.create(tee_time)
    end
  end

  def get_doc_to_parse
    #url = "http://www.golfnow.com/seattle/tee-times/golf-courses/wa---seattle-metro/search?FID=-1&OID=9543&AID=61&SID={01E99287-F7C4-4A11-9828-3A0C5F9499B0}&FDT=3/27/2014%2012:00:00%20AM&TDT=3/27/2014%2012:00:00%20AM&PPN=all"
    url = "http://www.golfnow.com/seattle/tee-times/golf-courses/wa---seattle-metro/search"
    doc = Nokogiri::HTML(open(url))
  end
end
