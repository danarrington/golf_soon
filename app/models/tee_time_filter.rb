class TeeTimeFilter
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::AttributeMethods
  attr_accessor :days, :players, :sort_by, :user

  def initialize(attributes={})
    attributes ||= default_params
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  def default_params
    f = {}
    f[:days] = 'weekend'
    f[:players] = 4
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
            players: {value: 'players', selected: sort_by=='players', print: 'Players'}
        }
    }
  end

  def self.empty
    TeeTimeFilter.new
  end

  def persisted?; true end

  def id; 1 end

end
