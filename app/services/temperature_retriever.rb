class TemperatureRetriever
  def get_temps(start_date, end_date)
    temps = []
    if end_date.nil?
      temps = Temperature.where("created_at >= ?", start_date).order('created_at ASC')
    else
      temps = Temperature.where(:created_at => start_date..end_date).order('created_at ASC')
    end
    temps
  end
end