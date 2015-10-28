class MainController < ApplicationController
  def index

    start_date = 5.days.ago.beginning_of_day
    temp_ret = TemperatureRetriever.new()
    @temps = temp_ret.get_temps(start_date, nil)

  end
end