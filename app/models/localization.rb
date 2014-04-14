class Localization < ActiveRecord::Base
  belongs_to :movie
  belongs_to :location
  validates :movie_id, presence: true
  validates :location_id, presence: true
end
