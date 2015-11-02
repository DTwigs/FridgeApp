class Api::TemperatureController < ApplicationController
  def index
    start_date = DateTime.parse(params[:start_date])
    end_date = DateTime.parse(params[:end_date]) if params[:end_date].present?

    tr = ::TemperatureRetriever.new(start_date, end_date)
    render json: {success: true, temps: tr.get_temps}
  rescue => e
    render json: {success: false, error: e.message, status: :forbidden}
  end
end