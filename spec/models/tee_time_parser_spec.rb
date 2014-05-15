require 'spec_helper'

describe TeeTimeParser do

  subject(:time) { TeeTimeParser.new.get_tee_time(@cube, @date)}

  before :each do
    f = File.open('spec/test_pages/one_result.html')
    doc = Nokogiri::XML(f)
    @date = Date.today-1
    @cube = doc.css('.cubeWrapper').first
    f.close

  end

  #its(:tee_time) { should eq '11:57'}
  it 'uses the provided date for the tee time' do
    expect(subject.tee_time.to_date).to eq @date
  end

  it 'parses the tee time' do
    expect(subject.tee_time.to_time.hour).to eq 13
    expect(subject.tee_time.to_time.min).to eq 57
  end

  its(:price) { should eq 13.0}
  its(:players) { should eq 2}
  its(:percent_off) { should eq 80}
  its(:booking_link) { should eq '/seattle/tee-times/golf-courses/wa---seattle-metro/details?TID=216056326&TType=DISC'}
  its(:course_id) { should eq 1037905}


end