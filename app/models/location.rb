class Location < ActiveRecord::Base
  searchkick autocomplete: ['name']
  validates :name, presence:true, uniqueness:true
  has_many :localizations
  has_many :movies, :through => :localizations
end
