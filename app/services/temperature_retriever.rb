class TemperatureRetriever
  STD_TIME_INTERVAL = 10

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

  def get_temps(add_gaps = true)
    temps = []
    if @end_date.nil?
      temps = Temperature.where("created_at >= ?", @start_date).order('created_at ASC')
    else
      temps = Temperature.where(:created_at => @start_date..@end_date).order('created_at ASC')
    end
    build_temps_by_day(temps, add_gaps)
  end

  def build_temps_by_day(temps, add_gaps = true)
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
      temps_by_day[key] = temps_found #add_gaps ? fill_in_gaps(temps_found, s, e) : temps_found
    end
    temps_by_day
  end

  def get_minute_difference(time1, time2)
    ((time2 - time1) / 60).to_i
  end

  def create_time_gap(mins, last_recorded_date)
    {
      gap: mins,
      created_at: last_recorded_date + (mins/2).minutes
    }
  end

  # TODO: Add specs
  # TODO: Handle situation when no data at beginning of time span
  # TODO: Handle situation when no data at end of time span
  def fill_in_gaps(temps, start_date, end_date)
    filled_in = []
    last_time = Time.parse(start_date.to_s)

    temps.each do |t|
      gap = add_gap(last_time, t.created_at)
      filled_in.push(gap) unless gap.nil?
      filled_in.push(t)
      last_time = t.created_at
    end

    #Add time gap at end of date range
    end_time = Time.parse(end_date.to_s) || Time.now
    t_last = temps.last ? temps.last.created_at : last_time
    gap = add_gap(t_last, end_time)
    filled_in.push(gap) unless gap.nil?
    filled_in
  end

  def add_gap(time1, time2)
    gap = nil
    min_diff = get_minute_difference(time1, time2)
    # Add in a record that represents a time gap
    if min_diff > (STD_TIME_INTERVAL * 1.5)
      gap = create_time_gap(min_diff, time1)
    end
    gap
  end

  private

  def set_pacific_time(date)
    date.change(offset: "-800")
  end
end

