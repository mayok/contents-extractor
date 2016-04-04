module Api
  class PagesController < ApplicationController

    protect_from_forgery :except  => ["create"]

    def index
      if user = User.find_by(token: params[:token])
        render json: user.pages, only: [:id, :url, :title]
      else
        render json: {
          ok: false,
          error: "invalid token"
        }
      end
    end

    def show
      if user = User.find_by(token: params[:token])
        if page = user.pages.find(params[:id])
          render json: page
        else
          render json: {
            ok: false,
            error: "invalid page id"
          }
        end
      else
        render json: {
          ok: false,
          error: "invalid token"
        }
      end
    end

    def create
      if user = User.find_by(token: params[:token])
        page = user.pages.build(page_params)
        page.update_attributes(page.extract) if page.valid?

        if page.save
          render json: { ok: true }
        else
          render json: {
            ok: false,
            error: "invalid url"
          }
        end
      else
        render json: {
          ok: false,
          error: "invalid token"
        }
      end
    end

    private
      def page_params
        ActionController::Parameters.new(params).permit(:url)
      end

  end
end
