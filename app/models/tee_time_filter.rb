class TeeTimeFilter
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::AttributeMethods
  attr_accessor :days, :min_players, :sort_by, :user

  def initialize(attributes={})
    attributes ||= default_params
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  def default_params
    f = {}
    f[:days] = 'weekend'
    f[:min_players] = '2'
    f[:sort_by] = 'percent_off'
    f
  end

  def hash
    {
        days: {
            weekend: {value: 'weekend', selected: days=='weekend', print: 'Weekend'},
            all: {value: 'all', selected: days == 'all', print: 'All'}
        },
        sort_by: {
            tee_time: {value: 'tee_time', selected: sort_by=='tee_time', print: 'Tee Time'},
            percent_off: {value: 'percent_off', selected: sort_by=='percent_off', print: 'Savings'},
            players: {value: 'price', selected: sort_by=='price', print: 'Price'}
        },
        min_players: {
            four: {value: '4', selected: min_players=='4', print: '4 Players'},
            three: {value: '3', selected: min_players=='3', print: '3 Players'},
            two: {value: '2', selected: min_players=='2', print: '2 Players'},
        }
    }
  end

  def self.empty
    TeeTimeFilter.new
  end

  def persisted?; true end

  def id; 1 end

end
