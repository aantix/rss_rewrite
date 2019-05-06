class RssesController < ApplicationController
  before_action :set_rss, only: :show

  def index
    @rsses = Rss.all
  end

  def show
    @posts = Rails.cache.read("feed-#{params[:id]}")
  end

  private
    def set_rss
      @rss = Rss.find_by(uid: params[:id])
    end

    def rss_params
      params.require(:rss).permit(:name, :uid, :url)
    end
end
