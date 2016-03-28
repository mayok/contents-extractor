require 'open-uri'

class Page < ActiveRecord::Base
  validates :url,   presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :host,  presence: true
  validates :title, presence: true

  def extract url
    contents = [
      "//div[@class='main' or @id='main']",
      "//div[@class='entry-content']",
      "//div[contains(@class, 'content') or contains(@id, 'content')]",
      "//div[@class='body']",
      "//body"
    ]
    str = [
      "//script",
      "//style",
      "//iframe",
      "//*[starts-with(@class, 'ad') or starts-with(@id, 'ad')]",
      "//*[contains(@class, 'comment') or contains(@id, 'comment')]",
      #"//a[not(contains(@href, '#{host}'))]",
    ]

    p url

    charset = nil
    open url do |f|
      charset = f.charset
    end

    #html = open(url, "r:#{charset}").read
    #html.encode!('utf-8', charset, invalid: :replace, undef: :replace)
    html = open(url, "r:utf-8").read.encode('utf-8', charset, invalid: :replace, undef: :replace)
    doc = Nokogiri::HTML.parse html

    # title
    title = doc.search("//title").text || "no title"

    # contents
    for p in contents do
      f = doc.search(p)
      if f
        doc = f
        break
      end
    end

    # remove script, comments,
    for p in str do
      doc.xpath(p).each do |el|
      	el.remove
      end
    end

    {
      host: url.split('/')[2],
      title: title,
      content: doc.to_html,
    }

  end
end
