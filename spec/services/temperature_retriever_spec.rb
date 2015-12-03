require 'rails_helper'

describe TemperatureRetriever do

  describe "#get_temps" do
    let(:temp1) { Temperature.create(temperature: 35, created_at: "2015-10-05 00:00:00 -0800") }
    let(:temp2) { Temperature.create(temperature: 39, created_at: "2015-10-04 00:00:00 -0800") }
    let(:temp3) { Temperature.create(temperature: 42, created_at: "2015-10-03 00:00:00 -0800") }
    let(:temp4) { Temperature.create(temperature: 32, created_at: "2015-10-02 00:00:00 -0800") }

    before do
      temp1;temp2;temp3;temp4
    end

    it 'returns a range of temperatures if start and end dates provided' do
      tr = TemperatureRetriever.new("2015-10-03", "2015-10-04")
      temps = tr.get_temps
      expect(temps.size).to eq(2)
      expect(temps["2015-10-03"].at(0).temperature).to eq(42)
    end

    it 'returns all temperatures more recent than the date provided' do
      tr = TemperatureRetriever.new("2015-10-03 00:00:00 -0800", nil) ##had to manually set timezone to avoid adding extra day in range
      temps = tr.get_temps
      expect(temps["2015-10-03"].at(0).temperature).to eq(42)
      expect(temps.max[0]).to eq(DateTime.now.strftime('%Y-%m-%d'))
    end
  end

  describe "#get_minute_difference" do
    let(:temp1) { Temperature.create(temperature: 35, created_at: "2015-10-05 01:30") }
    let(:temp2) { Temperature.create(temperature: 39, created_at: "2015-10-05 01:42") }
    let(:temp3) { Temperature.create(temperature: 42, created_at: "2015-10-05 03:17") }

    it 'returns the difference between two dates in minutes' do
      tr = TemperatureRetriever.new("2015-10-05", nil)
      expect(tr.get_minute_difference(temp1.created_at, temp2.created_at)).to eq(12)
      expect(tr.get_minute_difference(temp2.created_at, temp3.created_at)).to eq(95)
    end
  end

  describe "#build_temps_by_day" do
    let(:temps) { [Temperature.create(temperature: 35, created_at: "2015-10-04 02:00:00 -0800"), 
                   Temperature.create(temperature: 35, created_at: "2015-10-03 01:00:00 -0800"), 
                   Temperature.create(temperature: 39, created_at: "2015-10-03 00:00:00 -0800"), 
                   Temperature.create(temperature: 42, created_at: "2015-10-02 02:00:00 -0800"), 
                   Temperature.create(temperature: 32, created_at: "2015-10-02 01:00:00 -0800"), 
                   Temperature.create(temperature: 32, created_at: "2015-10-01 00:00:00 -0800")] }

    it 'groups returned temperature data based on the day it was created' do
      tr = TemperatureRetriever.new("2015-10-01", "2015-10-04")
      temps_by_day = tr.build_temps_by_day(temps)
      expect(temps_by_day.size).to eq(4)
    end

    it 'includes all temperature data for that day in an array' do
      tr = TemperatureRetriever.new("2015-10-01", "2015-10-04")
      temps_by_day = tr.build_temps_by_day(temps)
      expect(temps_by_day["2015-10-03"].length).to eq(2)
      expect(temps_by_day["2015-10-04"].length).to eq(1)
    end

    it 'includes all dates in range, even for days with no data' do
      tr = TemperatureRetriever.new("2015-10-01", "2015-10-06")
      temps_by_day = tr.build_temps_by_day(temps)
      expect(temps_by_day.size).to eq(6)
    end
  end
end
