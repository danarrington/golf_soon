class Course < ActiveRecord::Base
  has_many :favorites
  has_many :users, :through=> :favorites
  has_many :tee_times
end
