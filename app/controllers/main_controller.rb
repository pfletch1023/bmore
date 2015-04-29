class MainController < ApplicationController

  def index
    @images = Image.limit(100)
  end

end
