class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def create
    page = Page.new(page_params)

    page.update_attributes(Page.extract(page.url)) if page.valid?
    if page.save
      flash[:success] = "Successfully page added!"
    else
      flash[:fail]    = "failed"
    end
    redirect_to root_url

  end

  private
    def page_params
      params.require(:page).permit(:url)
    end
end
