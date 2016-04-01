module Api
  class PagesController < ApplicationController

    protect_from_forgery :except  => ["create"]

    def index
      @pages = Page.all
      render json: @pages, only: [:id, :url, :title]
    end

    def show
      @page = Page.find(params[:id])
      render json: @page
    end

    def create
      @page = Page.new(page_params)
      @page.update_attributes(Page.extract @page.url)

      if @page.save
        render json: { ok: true }
      else
        render json: {
          ok: false,
          error: "invalid url"
        }
      end
    end

    private
      def page_params
        params.require(:page).permit(:url)
      end

  end
end
