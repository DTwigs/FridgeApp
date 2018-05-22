class MainController < ApplicationController
  def index
    retriever_object = TemperatureRetriever.new(start_date, nil)
    @temps = retriever_object.get_temps.to_json
  end

  private

  def start_date
  	4.days.ago.beginning_of_day.to_datetime
  end
end
