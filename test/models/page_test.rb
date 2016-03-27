require 'test_helper'

class PageTest < ActiveSupport::TestCase
  def setup
    @page = Page.new(
      title: "hoge",
      url: "http://example.com",
      host: "example.com",
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

  test "host should be present" do
    @page.host = "     "
    assert_not @page.valid?
  end

  test "title should be present" do
    @page.title = "     "
    assert_not @page.valid?
  end
end
