module PageProcessor

  def delete_old
    Page.where("user_id = ? and created_at < ?", user_id, 3.days.ago).delete_all
  end

  def extract
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
      title: title,
      content: doc.to_html,
    }

  end
end
