class TeeTime < ActiveRecord::Base
  belongs_to :course

  def pretty_price
    "$%.2f" % self[:price]
  end

  def self.get_times(options)
    query = all.where('tee_time > ?', Time.now)
    query = query.where(course_id: options.user.courses.collect(&:id)) if options.user
    if options.days == 'weekend'
      saturday = Date.commercial(Date.today.year, Date.today.cweek, 6).in_time_zone('Pacific Time (US & Canada)')
      query = query.where(tee_time: (saturday .. saturday + 2.days))
    end

    if options.sort_by
      sort_direction = options.sort_by == 'tee_time' ? 'asc' : 'desc'
      query = query.order("#{options.sort_by} #{sort_direction}")

    end

    query.includes(:course)
  end
end