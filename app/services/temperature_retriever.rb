class TemperatureRetriever
  STD_TIME_INTERVAL = 10.minute

  def get_temps(start_date, end_date, add_gaps = true)
    temps = []
    if end_date.nil?
      temps = Temperature.where("created_at >= ?", start_date).order('created_at ASC')
    else
      temps = Temperature.where(:created_at => start_date..end_date).order('created_at ASC')
    end
    add_gaps ? fill_in_gaps(temps) : temps
  end

  def get_minute_difference(temp1, temp2)
    time1 = temp1.created_at
    time2 = temp2.created_at
    (time2 - time1) / 60
  end

  def create_time_gap(mins, last_recorded_date)
    {
      gap: mins,
      created_at: last_recorded_date + (mins/2).minutes
    }
  end

  def fill_in_gaps(temps)
    filled_in = []
    last_temp = nil

    temps.each do |t|
      if last_temp.nil?
        filled_in.push(t)
      else
        min_diff = get_minute_difference(last_temp, t)

        if min_diff > (STD_TIME_INTERVAL * 1.5)
          gap = create_time_gap(min_diff, last_temp.created_at)
          filled_in.push(gap)
        end

        filled_in.push(t)
        last_temp = t
      end
    end

    filled_in
  end
end

