class TeeTimeController < ApplicationController


  def times
    filter = TeeTimeFilter.new(params[:tee_time_filter])
    filter.user = current_user
    @tee_times = TeeTime.get_times(filter)
    @filter = filter
  end
end


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
    f[:sort_by] = 'savings'
    f
  end

  def hash
    {
        days: {
            weekend: {value: 'weekend', selected: days=='weekend', print: 'Weekend'},
            all: {value: 'all', selected: days == 'all', print: 'All'}
        }
    }
  end

  def self.empty
    TeeTimeFilter.new
  end

  def persisted?; true end

  def id; 1 end

end
