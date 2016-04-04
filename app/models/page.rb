require 'open-uri'

class Page < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  default_scope -> { order(created_at: :desc) }
  after_save  :delete_old

  include PageProcessor
end
