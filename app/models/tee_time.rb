class TeeTime < ActiveRecord::Base
  belongs_to :course

  def pretty_price
    "$%.2f" % self[:price]
  end

  def self.get_times(options = {})
    query = all.where('tee_time > ?', Time.now)
    query = query.where(course_id: options[:user].courses.collect(&:id)) if options[:user]

    query
  end
end