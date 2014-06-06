class TeeTime < ActiveRecord::Base
  belongs_to :course

  def pretty_price
    "$%.2f" % self[:price]
  end

  def self.get_times(options)
    last_data_run = DataRun.last
    query = all.where('tee_time > ?', Time.now).where(last_data_run_id: last_data_run.id)
    query = query.where(course_id: options.user.courses.collect(&:id)) if options.user
    if options.days == 'weekend'
      saturday = Date.commercial(Date.today.year, Date.today.cweek, 6).in_time_zone('Pacific Time (US & Canada)')
      query = query.where(tee_time: (saturday .. saturday + 2.days))
    end

    if options.sort_by
      sort_direction = options.sort_by == 'percent_off' ? 'desc' : 'asc'
      query = query.order("#{options.sort_by} #{sort_direction}")
    end

    if options.min_players
      query = query.where("players >= #{options.min_players}")
    end

    query.includes(:course)
  end
end