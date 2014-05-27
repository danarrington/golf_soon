require 'spec_helper'

describe TeeTime do

  it 'does not return past tee times' do
    past_time = create(:tee_time, tee_time: Date.yesterday)
    future_time = create(:tee_time, tee_time: Date.tomorrow)

    times = TeeTime.get_times(TeeTimeFilter.new)
    expect(times.count).to eq 1
    expect(times).not_to include past_time
  end

  context 'when passed a user' do
    it 'only returns times for users favorite courses' do
      user = create(:user, :with_favorite)
      time_from_favorite = create(:tee_time, course: user.courses.first)
      time_from_other = create(:tee_time, course: create(:course))

      times = TeeTime.get_times(TeeTimeFilter.new(user: user))
      expect(times.count).to eq 1
      expect(times).not_to include time_from_other
    end
  end

  it 'returns only weekend times when filtered by weekend' do
    filter = TeeTimeFilter.new(days: 'weekend')
    monday = Date.commercial(Date.today.year, Date.today.cweek, 1)
    tuesday_time = create(:tee_time, tee_time: monday+1.day)
    saturday_time = create(:tee_time, tee_time:monday+5.days)
    Timecop.travel(monday) do
      times = TeeTime.get_times(filter)
      expect(times).not_to include tuesday_time
    end
  end

  context 'when sort_by is set' do
    it 'can sort by tee time' do
      create(:tee_time, tee_time: 5.hour.from_now)
      early_time = create(:tee_time, tee_time: 1.hour.from_now)

      times = TeeTime.get_times(TeeTimeFilter.new(sort_by: 'tee_time'))
      expect(times.first).to eq early_time
    end

    it 'can sort by savings' do
      create(:tee_time, percent_off: 5)
      more_off = create(:tee_time, percent_off: 80)

      times = TeeTime.get_times(TeeTimeFilter.new(sort_by: 'percent_off'))
      expect(times.first).to eq more_off
    end

    it 'can sort by number of players' do
      create(:tee_time, players: 2)
      more_players = create(:tee_time, players: 4)

      times = TeeTime.get_times(TeeTimeFilter.new(sort_by: 'players'))
      expect(times.first).to eq more_players
    end
  end
end


