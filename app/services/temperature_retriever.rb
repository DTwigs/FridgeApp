class TemperatureRetriever
  def get_temps(start_date, end_date)
    if end_date.nil?
      temps = Temperature.where("created_at >= ?", start_date)
    else
      temps = Temperature.where("created_at BETWEEN ? and ?", start_date, end_date)
    end
    temps
  end
end