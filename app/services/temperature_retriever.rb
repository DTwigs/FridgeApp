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
      @end_date = DateTime.now
    end
  end

  def get_temps(add_gaps = true)
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
        # require 'pry';binding.pry
        if range.cover?(temp.created_at.to_datetime) 
          temps_found.push(temp)
        end
      end
      key = date.strftime('%Y-%m-%d')
      temps_by_day[key] = temps_found
    end
    temps_by_day
    # add_gaps ? fill_in_gaps(temps, s, e) : temps
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
    last_time = start_date

    temps.each do |t|
      gap = add_gap(Time.parse(last_time.to_s), t.created_at)
      filled_in.push(gap) unless gap.nil?
      filled_in.push(t)
      last_time = t.created_at
    end

    #Add time gap at end of date range
    end_time = end_date || Time.now
    t_last = temps.last
    gap = add_gap(t_last.created_at, Time.parse(end_time.to_s))
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
end

