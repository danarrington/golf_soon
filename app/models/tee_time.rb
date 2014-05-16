class TeeTime < ActiveRecord::Base
  belongs_to :course

  def pretty_price
    "$%.2f" % self[:price]
  end
end