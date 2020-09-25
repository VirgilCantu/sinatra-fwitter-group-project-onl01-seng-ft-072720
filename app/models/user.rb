class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.split.join("-")
  end

  def self.find_by_slug(slug)
    split_slug = slug.split("-").join(" ")
    User.find_by(username: split_slug)
  end

end
