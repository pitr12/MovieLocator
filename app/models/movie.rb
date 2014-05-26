class Movie < ActiveRecord::Base
  searchkick
  validates :title, presence: true
  validates :description, presence: true
  validates :year, presence: true
  validates_uniqueness_of :title, :scope => :year
  has_many :localizations
  has_many :locations, :through => :localizations
end
