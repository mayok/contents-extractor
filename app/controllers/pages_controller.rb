class PagesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def show
    @page = current_user.pages.find_by(id: params[:id])
  end

  def create
    page = current_user.pages.build(page_params)
    url = normalize(page.url)
    page.update_attributes(url: url)
    page.update_attributes(page.extract) if page.valid?

    if page.save
      flash[:success] = "Successfully page added!"
    else
      flash[:fail]    = "failed"
    end
    redirect_to root_url
  end

  def destroy

  end

  private
    def page_params
      params.require(:page).permit(:url)
    end

    def normalize(url)
      Addressable::URI.parse(url).normalize.to_s
    end
end
