require 'cgi'

class User < ActiveRecord::Base
  has_secure_password
  has_many :farms
  has_many :farm_vegetables, through: :farms
  has_many :vegetables, through: :farm_vegetables

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  def slug
    slug = username.downcase.tr(' ', '-').delete("'")
    CGI.escape(slug)
  end

  def self.find_by_slug(slug)
    slug = CGI.escape(slug)
    User.find { |user| user.slug == slug }
  end
end
