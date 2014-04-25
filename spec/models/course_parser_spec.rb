require 'spec_helper'

describe CourseParser do


  subject(:course_parser) {CourseParser.new.get_course_info 123}

  before :each do
    f = File.open('spec/test_pages/kenwanda.aspx.html')
    doc = Nokogiri::XML(f)
    f.close
    CourseParser.any_instance.stub(:get_course_doc){doc}
  end

  its(:name) {should eq 'Kenwanda Golf Course'}
  its(:gn_id) {should eq 123}
  its(:city) {should eq 'Snohomish'}
  its(:state) {should eq 'WA'}
  its(:zip) {should eq '98296'}
  its(:address) {should eq '14030 Kenwanda Dr'}
  its(:holes) {should eq 18}
  its(:par) {should eq 69}
  its(:yards) {should eq 5336}
  its(:rating) {should eq 64.1}
  its(:slope) {should eq 101}
end