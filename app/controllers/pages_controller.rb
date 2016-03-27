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
      flash[:success] = "Successfully page added!"
      redirect_to root_url
    else
      flash[:fail]    = "failed"
      redirect_to root_url
    end

    # respond_to do |format|
    #   format.html { render nothing: true }
    # end
  end

  def destroy
  end

  private
    def page_params
      params.require(:page).permit(:url)
    end
end
