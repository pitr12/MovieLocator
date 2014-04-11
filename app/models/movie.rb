class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :year, presence: true
  has_many :localizations
  has_many :locations, :through => :localizations
end
