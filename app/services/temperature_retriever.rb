class TemperatureRetriever

  def initialize(start_date, end_date)
    @start_date = verify_and_parse_date(start_date)
    @end_date = verify_and_parse_date(end_date)
  end

  def verify_and_parse_date(date)
    if date.present? && date.is_a?(String)
      DateTime.parse(date)
    elsif date.is_a?(DateTime)
      date
    else
      DateTime.now
    end
  end 

  def get_temps
    temps = []
    if @end_date.nil?
      temps = Temperature.where("created_at >= ?", @start_date).order('created_at ASC')
    else
      temps = Temperature.where(:created_at => @start_date..@end_date).order('created_at ASC')
    end
    build_temps_by_day(temps)
  end

  def build_temps_by_day(temps)
    temps_by_day = {}
    total_range = @start_date.beginning_of_day..@end_date.end_of_day
    total_range.each do |date|
      range = date.beginning_of_day..date.end_of_day
      temps_found = temps.map do |temp|
        if range.cover?(temp.created_at.to_datetime)
          temp
        end
      end.compact
      key = date.strftime('%Y-%m-%d')
      temps_by_day[key] = temps_found
    end
    temps_by_day
  end

  def get_minute_difference(time1, time2)
    ((time2 - time1) / 60).to_i
  end

end

