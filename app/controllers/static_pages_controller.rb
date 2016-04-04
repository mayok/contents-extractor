class StaticPagesController < ApplicationController
  def home
    @pages = current_user.pages.all if logged_in?
  end
end
