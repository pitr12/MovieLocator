class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :year, presence: true
end
