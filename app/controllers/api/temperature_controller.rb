class Api::TemperatureController < ApplicationController
  def index
    tr = ::TemperatureRetriever.new(start_date, end_date)
    render json: {success: true, temps: tr.get_temps}
  rescue => e
    render json: {success: false, error: e.message, status: :forbidden}
  end

  def receive
    temp_in_c = params.fetch(:temperature).to_f
    temp_in_f = temp_in_c * 1.8 + 32
    t = Temperature.new(temperature: temp_in_f)
    if t.save
      render json: {success: true}
    else
      render json: {success: false, error: "failed to save temperature data"}
    end
  rescue => e
    render json: {success: false, error: e.message, status: :forbidden}
  end

  def start_date
    params[:start_date]
  end

  def end_date
    params[:end_date]
  end
end