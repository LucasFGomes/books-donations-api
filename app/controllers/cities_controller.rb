class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :destroy]

  def index
    @cities = City.all
    render json: @cities, status: :ok
  end

  def show
    render json: @city, status: :ok
  end

  def destroy
    @city.destroy
  end

  private

  def set_city
    @city = City.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'City not found' }, status: :not_found
  end
end
