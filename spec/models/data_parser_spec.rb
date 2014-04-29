require 'spec_helper'

describe DataParser do

  subject(:data_parser) {DataParser.new}
  context 'parsing page with unknown course' do

    before :each do
      f = File.open('spec/test_pages/one_result.html')
      doc = Nokogiri::XML(f)
      f.close
      subject.stub(:get_doc_to_parse){doc}

      f2 = File.open('spec/test_pages/kenwanda.aspx.html')
      doc2 = Nokogiri::XML(f2)
      f2.close
      CourseParser.any_instance.stub(:get_course_doc){doc2}
    end

    it 'saves the unknown course' do

      subject.get_latest_times

      expect(Course.count).to eq 1
    end
  end

  context 'parsing page with only known courses' do
    before :each do
      f = File.open('spec/test_pages/one_result.html')
      doc = Nokogiri::XML(f)
      f.close
      subject.stub(:get_doc_to_parse){doc}
      FactoryGirl.create(:course, id: 1037905) #course id in one_result
    end

    it 'does not save any courses' do
      CourseParser.should_receive(:new).exactly(0).times

      subject.get_latest_times
    end
  end
end