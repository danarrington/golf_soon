class TeeTimeParser

  def self.get_tee_time(cube, date)

    time = Time.zone.parse(cube.css('.time').first.text)
    datetime = Time.zone.local(date.year, date.month, date.day, time.hour, time.min, 0)

    price = cube.css('.cost').first.text.match(/\$(?<price>\d+\.\d+)/)[:price].to_f
    players = cube.css('.player option').last.text
    savings = cube.css('.savings').first.text.match(/(?<percent>\d+)%/)[:percent].to_i unless cube.css('.savings').first.text.empty?
    savings ||= 0
    link = cube.css('.btnCubeLink .orangeButton').first['href'] if cube.css('.btnCubeLink .orangeButton').any?
    course_id = cube.css('.courseName a').first['productid'].to_i
    gn_id = cube.css('.icons').first['id'].match(/TTS_(\d*)/)[1].to_i

    {tee_time: datetime, price: price, players: players,
                percent_off: savings, booking_link: link,
                course_id: course_id, gn_id:gn_id}

  end
end