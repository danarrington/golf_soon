class TeeTimeParser

  def self.get_tee_time(cube, date)

    time = Time.parse(cube.css('.time').first.text)
    datetime = DateTime.new(date.year, date.month, date.day, time.hour, time.min, 0).change(:offset=>time.zone)

    price = cube.css('.cost').first.text.match(/\$(?<price>\d+\.\d+)/)[:price]
    players = cube.css('.player option').last.text
    savings = cube.css('.savings').first.text.match(/(?<percent>\d+)%/)[:percent].to_i
    link = cube.css('.btnCubeLink .orangeButton').first['href']
    course_id = cube.css('.courseName a').first['productid'].to_i

    TeeTime.new(tee_time: datetime, price: price, players: players,
                percent_off: savings, booking_link: link, course_id: course_id)

  end
end