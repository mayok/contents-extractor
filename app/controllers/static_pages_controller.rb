class StaticPagesController < ApplicationController
  def home
    @pages = current_user.pages.all
  end
end
