require 'test_helper'

class PageTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @page = @user.pages.build(
      title: "hoge",
      url: "http://www.yahoo.co.jp",
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

  test "order should be most recent first" do
    assert_equal pages(:most_recent), Page.first
  end

end
