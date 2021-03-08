class Member < ApplicationRecord

  validates :name, length: (1..255)
  validates :url, length: (1..255), uniqueness: true, url: true
  validates :short_url, length: (0..255), allow_blank: true

end
