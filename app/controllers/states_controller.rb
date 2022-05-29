class StatesController < ApplicationController
  before_action :set_state, only: [:show, :destroy]

  def index
    @states = State.all
    render json: @states, status: :ok
  end

  def show
    render json: @state, status: :ok
  end

  def destroy
    @state.destroy
  end

  private

  def set_state
    @state = State.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'State not found' }, status: :not_found
  end
end
