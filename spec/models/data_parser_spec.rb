require 'spec_helper'

describe DataParser do

  subject(:data_parser) {DataParser.new}
  context 'parsing page with unknown course' do

    it 'saves the unknown course' do

      pending 'save course info first'
      subject.get_latest_times

      expect(Course.count).to eq 1
    end
  end
end