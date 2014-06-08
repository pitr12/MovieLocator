class Location < ActiveRecord::Base
  searchkick autocomplete: ['name']
  geocoded_by :name
  validates :name, presence:true, uniqueness:true
  after_validation :geocode
  has_many :localizations
  has_many :movies, :through => :localizations
end
