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

      subject.find_times_for

      expect(Course.count).to eq 1
    end

    it 'adds the new course id to known course ids' do
      subject.find_times_for

      expect(subject.instance_variable_get(:@known_course_ids)).to include Course.last.gn_id
    end
  end

  context 'parsing page with only known courses' do
    before :each do
      f = File.open('spec/test_pages/one_result.html')
      doc = Nokogiri::XML(f)
      f.close
      subject.stub(:get_doc_to_parse){doc}
      FactoryGirl.create(:course, gn_id: 1037905) #course id in one_result
    end

    it 'does not save any courses' do
      CourseParser.should_receive(:new).exactly(0).times

      subject.find_times_for
    end
  end

  context 'parsing page with one tee time' do

    before :each do
      f = File.open('spec/test_pages/one_result.html')
      doc = Nokogiri::XML(f)
      f.close
      subject.stub(:get_doc_to_parse){doc}
      FactoryGirl.create(:course, gn_id: 1037905, id: 3) #course id in one_result
    end

    it 'gets the tee time info' do
      TeeTimeParser.should_receive(:get_tee_time).and_call_original
      subject.find_times_for
    end

    it 'saves the tee time' do
      TeeTime.any_instance.should_receive(:save)
      subject.find_times_for
    end

    it 'sets the course_id to our id, not gn id' do
      subject.find_times_for
      expect(TeeTime.last.course_id).to eq 3
    end

    context 'with existing tee time that has changed' do
      before :each do
        TeeTime.create(course_id: 3, gn_id: 216056326, price: 10.0)
      end

      it 'updates existing tee time' do
        subject.find_times_for
        expect(TeeTime.count).to eq 1
        expect(TeeTime.last.price).to eq 13.0
      end
    end

    context 'with existing tee time that has not changed' do
      before :each do
        TeeTime.create(course_id: 3, gn_id: 216056326,
        percent_off: 80, players: 2, booking_link: '/seattle/tee-times/golf-courses/wa---seattle-metro/details?TID=216056326&amp;TType=DISC',
        price: 13.0)
      end

      it 'does not update existing tee time' do
        updated_at = TeeTime.last.updated_at
        subject.find_times_for
        expect(TeeTime.count).to eq 1
        expect(TeeTime.last.updated_at.to_a).to eq updated_at.to_a
      end
    end

  end
end