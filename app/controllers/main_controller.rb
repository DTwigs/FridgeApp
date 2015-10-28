class MainController < ApplicationController
  def index
    @temps = Temperature.all
  end
end
