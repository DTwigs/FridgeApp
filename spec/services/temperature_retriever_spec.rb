require 'rails_helper'

describe TemperatureRetriever do

  describe "#get_temps" do
    let(:temp1) { Temperature.create(temperature: 35, created_at: "2015-10-05") }
    let(:temp2) { Temperature.create(temperature: 39, created_at: "2015-10-04") }
    let(:temp3) { Temperature.create(temperature: 42, created_at: "2015-10-03") }
    let(:temp4) { Temperature.create(temperature: 32, created_at: "2015-10-02") }

    it 'returns a range of temperatures if start and end dates provided' do
      expect(TemperatureRetriever.new.get_temps("2015-10-03", "2015-10-04")).to eq([temp3, temp2])
    end

    it 'returns all temperatures more recent than the date provided' do
      expect(TemperatureRetriever.new.get_temps("2015-10-03", nil)).to eq([temp3, temp2, temp1])
    end
  end
end