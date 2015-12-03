class TemperatureRetriever

  def initialize(start_date, end_date)
    if start_date.present? && start_date.is_a?(String)
      @start_date = DateTime.parse(start_date)
    else
      @start_date = start_date
    end

    if end_date.present? && end_date.is_a?(String)
      @end_date = DateTime.parse(end_date)
    else
      @end_date = end_date.is_a?(DateTime) ? end_date : DateTime.now
    end

    @start_date = set_pacific_time(@start_date)
    @end_date = set_pacific_time(@end_date) if @end_date.present?
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
      temps_found = []
      temps.each do |temp|
        if range.cover?(temp.created_at.to_datetime)
          temps_found.push(temp)
        end
      end
      key = date.strftime('%Y-%m-%d')
      s = range.cover?(@start_date) ? @start_date : date.beginning_of_day
      e = range.cover?(@end_date) ? @end_date : date.end_of_day
      temps_by_day[key] = temps_found
    end
    temps_by_day
  end

  def get_minute_difference(time1, time2)
    ((time2 - time1) / 60).to_i
  end

  private

  def set_pacific_time(date)
    date.change(offset: "-800")
  end
end

