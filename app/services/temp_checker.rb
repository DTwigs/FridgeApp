class TempChecker
  def initialize(message)
    @message = message
  end

  def perform
    temps = grab_temps
    if temps.count > 0
      if check_temps(temps)
        @message.body = "Temperature is too high"
        @message.send_text_message
      end
    else
      @message.body = "No temperature reading in the last 30 minutes"
      @message.send_text_message
    end
  end

  def grab_temps
    Temperature.where("created_at >= ?", (DateTime.now - 30.minutes))
  end

  def check_temps(temperatures)
    result = true
    temperatures.each do |temperature|
      if temperature.temperature < 40 
        result = false
      end
    end
    result
  end

end
