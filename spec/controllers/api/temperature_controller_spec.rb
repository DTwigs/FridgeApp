require 'rails_helper'

describe Api::TemperatureController do

  let(:temperature_data) { { "temp1" => 35, "temp2" => 36 } }

  context 'successful api calls' do
    before do
      expect_any_instance_of(::TemperatureRetriever).to receive(:get_temps) { temperature_data }
    end

    it 'shows a list of temperatures for a timespan' do
      get :index, params: { start_date: "2015-10-05 01:30", end_date: "2015-10-05 03:18" }

      expect(response).to be_success
      j = JSON.parse(response.body) #response.body is the json that returned from the controller
      expect(j).to eql({"success" => true, "temps" => temperature_data })
    end

    it 'shows a list of temperatures for a timespan' do
      get :index, params: { start_date: "2015-10-05 01:30" }

      expect(response).to be_success
      j = JSON.parse(response.body) #response.body is the json that returned from the controller
      expect(j).to eql({"success" => true, "temps" => temperature_data })
    end
  end

  context 'failed api calls' do
    before do
      allow_any_instance_of(::TemperatureRetriever).to receive(:get_temps) { temperature_data }
    end

    it 'returns error if invalid start date' do
      get :index, params: { start_date: "A Date", end_date: "2015-10-05 03:18" }

      e = JSON.parse(response.body)
      expect(e).to eql({"success" => false, "error" => "invalid date", "status" => "forbidden"})
    end

    it 'returns error if invalid start date' do
      get :index, params: { start_date: "2015-10-05 03:18", end_date: "End Date" }

      e = JSON.parse(response.body)
      expect(e).to eql({"success" => false, "error" => "invalid date", "status" => "forbidden"})
    end
  end
end
