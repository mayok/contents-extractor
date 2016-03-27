class Page < ActiveRecord::Base
  validates :url,  presence: true
  validates :host, presence: true
end
