require 'spec_helper'

describe TeeTime do

  it 'does not return past tee times' do
    past_time = create(:tee_time, tee_time: Date.yesterday)
    future_time = create(:tee_time, tee_time: Date.tomorrow)

    times = TeeTime.get_times
    expect(times.count).to eq 1
    expect(times).not_to include past_time
  end

  context 'when passed a user' do
    it 'only returns times for users favorite courses' do
      user = create(:user, :with_favorite)
      time_from_favorite = create(:tee_time, course: user.courses.first)
      time_from_other = create(:tee_time, course: create(:course))

      times = TeeTime.get_times({user: user})
      expect(times.count).to eq 1
      expect(times).not_to include time_from_other
    end
  end
  it 'returns only weekend times when filtered by weekend' do
    pending
    filter = {days: :weekend}

  end
end


