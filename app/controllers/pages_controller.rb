class PagesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def show
    @page = current_user.pages.find_by(params[:id])
    #@page = Page.find(params[:id])
  end

  def create
    page = current_user.pages.build(page_params)

    page.update_attributes(Page.extract(page.url)) if page.valid?
    if page.save
      flash[:success] = "Successfully page added!"
    else
      flash[:fail]    = "failed"
    end
  end

  def destroy

  end

  private
    def page_params
      params.require(:page).permit(:url)
    end
end
