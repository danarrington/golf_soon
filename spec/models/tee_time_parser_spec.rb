require 'spec_helper'

describe TeeTimeParser do

  subject(:time) { TeeTimeParser.get_tee_time(@cube, @date)}

  context 'with one valid result' do
    before :each do
      f = File.open('spec/test_pages/one_result.html')
      doc = Nokogiri::XML(f)
      @date = Date.today-1
      @cube = doc.css('.cubeWrapper').first
      f.close

    end

    #its(:tee_time) { should eq '11:57'}
    it 'uses the provided date for the tee time' do
      expect(subject[:tee_time].to_date).to eq @date
    end

    it 'parses the tee time' do
      expect(subject[:tee_time].to_time.in_time_zone('Pacific Time (US & Canada)').hour).to eq 13
      expect(subject[:tee_time].to_time.min).to eq 57
    end

    its([:price]) { should eq 13.0}
    its([:players]) { should eq '2'}
    its([:percent_off]) { should eq 80}
    its([:booking_link]) { should eq '/seattle/tee-times/golf-courses/wa---seattle-metro/details?TID=216056326&TType=DISC'}
    its([:course_id]) { should eq 1037905}
    its([:gn_id]) {should eq 216056326}
    its([:cart]) {should be_true}
    its([:holes]) {should eq 18}

  end

  context 'with one cranky result' do

    before :each do
      f = File.open('spec/test_pages/one_bad_result.html')
      doc = Nokogiri::XML(f)
      @date = Date.today-1
      @cube = doc.css('.cubeWrapper').first
      f.close
    end

    it 'should pass' do
      subject
    end


  end
end