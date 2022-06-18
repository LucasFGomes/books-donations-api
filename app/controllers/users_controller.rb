class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: [:update, :show, :destroy, :increase_credit]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/:id
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
  end

  def increase_credit
    unless @user.update(credit: params[:credit])
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end 
  end

  def give_note
    note = params[:note]
    donation_id = params[:donation_id]
    rate_user_id = params[:rate_user_id]
    donor_id = params[:donor]

    if donor_id
      Donation.find(donation_id).update(donor_evaluation: true, donor_note: note)  
    else
      Donation.find(donation_id).update(receiver_evaluation: true, receiver_note: note)  
    end

    user = User.where(id: rate_user_id).select('sum_notes, count_note').first

    new_count_note = user.count_note + 1

    new_sum_notes = (user.sum_notes + note);
    new_points = new_sum_notes / new_count_note

    user.update(points: new_points.to_f, sum_notes: new_sum_notes, count_note: new_count_note)
    
    if user.changed?
      render json: user, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
              status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params_list = [:id, :name, :username, :email, :city_id, :state_id, :credits, 
                   :points, :phone, :count_note, :sum_notes]
    params_list += [:password, :password_confirmation] unless params[:password].blank?
    params.permit(params_list)
  end
end
