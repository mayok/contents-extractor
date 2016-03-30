require 'test_helper'

class PageTest < ActiveSupport::TestCase
  def setup
    @page = Page.new(
      title: "hoge",
      url: "http://www.yahoo.co.jp",
      host: "www.yahoo.co.jp",
      content: "hgoehogehoge"
    )
  end

  test "should be valid" do
    assert @page.valid?
  end

  test "url should be present" do
    @page.url = "     "
    assert_not @page.valid?
  end

end
