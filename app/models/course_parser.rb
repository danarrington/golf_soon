class CourseParser

  def get_course_info(course_id)
    doc = get_course_doc course_id
    course_data = {}

    course_data[:name] = doc.css('strong').first.text.strip
    course_data[:gn_id] = course_id

    address_regex = doc.css('.popup-info p').first.text.strip.match(/(?<address>.+\w)\s{3,}(?<city>.*),\s*(?<state>[A-Z]*)\s*(?<zip>\d*)/)
    course_data[:city] = address_regex[:city]
    course_data[:state] = address_regex[:state]
    course_data[:zip] = address_regex[:zip]
    course_data[:address] = address_regex[:address]

    course_data[:holes] = doc.css('#CourseInfoBar1_lblHole').text.to_i
    course_data[:par] = doc.css('#CourseInfoBar1_lblPar').text.to_i
    course_data[:yards] = doc.css('#CourseInfoBar1_lblYards').text.gsub(/,/,'').to_i
    course_data[:rating] = doc.css('#CourseInfoBar1_lblRating').text.to_f
    course_data[:slope] = doc.css('#CourseInfoBar1_lblSlope').text.to_i

    Course.new(course_data)
  end

  def get_course_doc(course_id)
    Nokogiri::HTML(open(URI.escape("http://www.golfnow.com/CoursePopUp.aspx?facilityid=#{course_id}")))
  end
end