require 'rails_helper'

describe TemperatureRetriever do

  describe "#get_temps" do
    context 'no gaps filled' do
      let(:temp1) { Temperature.create(temperature: 35, created_at: "2015-10-04 00:00:00 -0800") }
      let(:temp2) { Temperature.create(temperature: 39, created_at: "2015-10-04 00:00:00 -0800") }
      let(:temp3) { Temperature.create(temperature: 42, created_at: "2015-10-03 00:00:00 -0800") }
      let(:temp4) { Temperature.create(temperature: 32, created_at: "2015-10-02 00:00:00 -0800") }

      before do
        temp1;temp2;temp3;temp4
      end

      it 'returns a range of temperatures if start and end dates provided' do
        tr = TemperatureRetriever.new("2015-10-03", "2015-10-04")
        temps = tr.get_temps(false)
        expect(temps.size).to eq(2)
        expect(temps["2015-10-03"].at(0).temperature).to eq(42)
      end

      it 'returns all temperatures more recent than the date provided' do
        tr = TemperatureRetriever.new("2015-10-03 00:00:00 -0800", nil) ##had to manually set timezone to avoid adding extra day in range
        temps = tr.get_temps(false) ## adding add_gaps = false argument only works when used without other methods
        expect(temps["2015-10-03"].at(0).temperature).to eq(42)
        expect(temps.max[0]).to eq(DateTime.now.strftime('%Y-%m-%d'))
      end
    end

    context 'with gaps filled in' do
      let(:temp1) { Temperature.create(temperature: 35, created_at: "2015-10-05 01:30 -0800") }
      let(:temp2) { Temperature.create(temperature: 39, created_at: "2015-10-05 01:42 -0800") }
      let(:temp3) { Temperature.create(temperature: 42, created_at: "2015-10-05 03:17 -0800") }

      before do
        temp1;temp2;temp3
      end

      it 'returns all temperatures and timegaps between temps' do
        tr = TemperatureRetriever.new("2015-10-05 01:29 -0800", "2015-10-05 03:18 -0800")
        temps = tr.get_temps
        expect(temps["2015-10-05"].length).to eq(4)
        expect(temps["2015-10-05"].at(2)[:gap]).to eq(95)
      end

      it 'returns all temperatures and timegaps at beginning of range' do
        tr = TemperatureRetriever.new("2015-10-05 01:09 -0800", "2015-10-05 03:18 -0800")
        temps = tr.get_temps
        expect(temps["2015-10-05"].length).to eq(5)
        expect(temps["2015-10-05"].at(0)[:gap]).to eq(21)
      end

      it 'returns all temperatures and timegaps at end of range' do
        tr = TemperatureRetriever.new("2015-10-05 01:29 -0800", "2015-10-05 03:33 -0800")
        temps = tr.get_temps
        expect(temps["2015-10-05"].length).to eq(5)
        expect(temps["2015-10-05"].at(4)[:gap]).to eq(16)
      end
    end
  end

  describe "#get_minute_difference" do
    let(:temp1) { Temperature.create(temperature: 35, created_at: "2015-10-05 01:30") }
    let(:temp2) { Temperature.create(temperature: 39, created_at: "2015-10-05 01:42") }
    let(:temp3) { Temperature.create(temperature: 42, created_at: "2015-10-05 03:17") }

    it 'returns the difference between two dates in minutes' do
      tr = TemperatureRetriever.new(nil, nil)
      expect(tr.get_minute_difference(temp1.created_at, temp2.created_at)).to eq(12)
      expect(tr.get_minute_difference(temp2.created_at, temp3.created_at)).to eq(95)
    end
  end

  describe '#create_time_gap' do
    it 'creates a hash with the gap of minutes and time' do
      tr = TemperatureRetriever.new(nil, nil)
      date = DateTime.parse("2015-10-04 01:30")
      gap = tr.create_time_gap(32, date)
      expect(gap).to eq({ gap: 32, created_at: date + (32/2).minutes})
    end
  end


end