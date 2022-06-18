class DonationsController < ApplicationController
  before_action :set_donation, only: [:destroy]

  def donation_infos
    @service = ::Api::V1::Donation::Informations.call(params[:user_id])
    render_service
  end

  def index
    @service = ::Api::V1::Donation::Index.call(params[:user_id])
    render_service
  end

  def create
    if !params[:receiver_id]
      render json: { error: 'É necessário ter um recebedor, para realizar a doação.' }, status: :unprocessable_entity
    end
    @donation = Donation.new(donation_params)

    if @donation.save
      render json: @donation, status: :created
    else
      render json: { errors: @donation.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @donation.destroy
  end

  def complete_donation
    donation_id = params[:donation_id]
    receiver_id = params[:receiver_id]
    user_id = params[:user_id]
    credit = params[:credit]

    donation = Donation.find(donation_id).update(status: 'completed')
    
    if donation
      donor_found = User.find user_id 
      receiver_found = User.find receiver_id

      donor_found.update(credits: donor_found + credit)
      receiver_found.update(credits: receiver_found - credit)
    end
  end

  def cancel_donation
    donation_id = params[:donation_id]

    donation = Donation.find_by(id: donation_id)
    
    if donation.nil?
      render json: { error: 'Doação não existe.'}, status: :unprocessable_entity
    else
      donation.update(status: 'canceled')
      render json: { message: 'Doação cancelada com sucesso.'}, status: :ok
    end
  end

  def render_service
    if @service.success?
      render json: @service.result, status: :ok
    else
      render json: { errors: @service.errors }, status: :service_unavailable
    end
  end

  private

  def set_donation
    @donation = Donation.find(params[:donation_id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Donation not found' }, status: :not_found
  end

  def donation_params
    params_list = [:id, :address, :date_delivery, :book_id, :receiver_id]
    params.permit(params_list)
  end
end

