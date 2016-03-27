class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirecto_to @page
    else
      render 'index'
    end
  end

  def destroy
  end

  private
    def page_params
      params.require(:page).permit(:url)
    end
end
