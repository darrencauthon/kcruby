class HomeController < ApplicationController
  def index
    @podcasts = Podcast.recent
  end
end
