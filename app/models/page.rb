require 'open-uri'

class Page < ActiveRecord::Base
  validates :url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  default_scope -> { order(created_at: :desc) }
  after_save  :delete_old

  def self.extract url
    contents = [
      "//*[contains(@class, 'content') or contains(@id, 'content')]",
      "//*[contains(@class, 'Content') or contains(@id, 'Content')]",
      "//*[@class='body' or @id='body']",
      "//*[@class='main' or @id='main']",
      "//body"
    ]
    str = [
      "//script",
      "//style",
      "//iframe",
      "//form",
      "//*[starts-with(@class, 'ad') or starts-with(@id, 'ad')]",
      "//*[contains(@class, 'comment') or contains(@id, 'comment')]",
      "//*[contains(@class, 'advertisement')]",
      "//*[contains(@class, 'footer') or contains(@class, 'Footer')]",
      "//*[contains(@class, 'social')]",
      "//*[contains(@class, 'modal')]",
      #"//a[not(contains(@href, '#{host}'))]",
    ]

    charset = nil
    open url do |f|
      charset = f.charset
    end

    html = open(url, "r:binary").read.encode("utf-8", charset, invalid: :replace, undef: :replace)
    doc = Nokogiri::HTML.parse html

    # title
    title = doc.xpath("//title")[0].text || "no title"

    # remove script, comments,
    for cond in str do
      doc.xpath(cond).each do |el|
      	el.remove
      end
    end

    # contents
    for cond in contents do
      f = doc.xpath(cond)
      if !f.empty?
        p cond
        doc = f.last
        break
      end
    end

    {
      host: url.split('/')[2],
      title: title,
      content: doc.to_html,
    }

  end

  def delete_old
    Page.where("created_at < ?", 1.week.ago).delete_all
  end
end
