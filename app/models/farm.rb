require 'cgi'

class Farm < ActiveRecord::Base
  belongs_to :user
  has_many :farm_vegetables
  has_many :vegetables, through: :farm_vegetables

  validates :name, presence: true
  validates :location, presence: true

  def slug
    slug = name.downcase.gsub(" ", "-").gsub("'", "")
    CGI.escape(slug)
  end
end
