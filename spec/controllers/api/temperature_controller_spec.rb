require 'rails_helper'

describe Api::TemperatureController do 
  it 'shows a list of temperatures for a timespan' do 
    temperature_data = { temp1: 35, temp2: 36 }
    expect_any_instance_of(::TemperatureRetriever).to receive(:get_temps) { temperature_data }
    get :index, :start_date => "2015-10-05 01:30", :end_date => "2015-10-05 03:18"
    expect(response).to be_success
    j = JSON.parse(response.body) #response.body is the json that returned from the controller
    expect(j).to eql({"success" => true, "temps" => {"temp1" => 35, "temp2" => 36}})
  end

  it 'returns false success if invalid start date' do 
    temperature_data = { temp1: 35, temp2: 36 }
    allow_any_instance_of(::TemperatureRetriever).to receive(:get_temps) { temperature_data }
    get :index, :start_date => "A Date", :end_date => "2015-10-05 03:18"
    e = JSON.parse(response.body)
    expect(e).to eql({"success" => false, "error" => "invalid date", "status" => "forbidden"})
  end

end