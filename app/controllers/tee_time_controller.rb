class TeeTimeController < ApplicationController


  def times
    filter = TeeTimeFilter.new(params[:tee_time_filter])
    Rails.logger.debug(filter.inspect)
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
    attributes ||= {}
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  def self.default_params
    f = {}
    f[:days] = 'weekend'
    f[:players] = 4
    f[:sort_by] = 'savings'
    f
  end

  def self.empty
    TeeTimeFilter.new
  end

  def persisted?; true end

  def id; 1 end

end
