class MainController < ApplicationController
  def index
    start_date = 5.days.ago.beginning_of_day.to_datetime
    temp_ret = TemperatureRetriever.new(start_date, nil)
    @temps = temp_ret.get_temps(false).to_json
  end
end
