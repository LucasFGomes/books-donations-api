class BooksController < ApplicationController
  before_action :set_donor, only: [:index, :create]
  before_action :set_book, only: [:show, :destroy, :register_interest, :register_donation]

  def index
    books = Book.joins(:pictures, donor: [city: :state])
                .where(has_interest: false, donated: false)
                .where.not(user_id: @donor.id)
                .select("
                  books.*,
                  pictures.url as picture_book,
                  users.name as user_name,
                  users.username,
                  users.email,
                  users.credits as user_credits,
                  users.points,
                  users.phone,
                  cities.id as city_id,
                  cities.name as city_name,
                  states.id as state_id,
                  states.name as state_name
                ")

    render json: books, status: :ok
  end

  def show
    render json: @book, status: :ok
  end

  def create
    @book = Book.new(book_params)
    urls = params[:url]
    
    if urls && urls != "" && urls.length > 0
      urls.each do |value|
        Picture.create(url: value, book_id: @book.id)
      end
    end

    if @book.save
      render json: @book, status: :created
    else
      render json: { errors: @book.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
  end

  def register_interest
    if @book.update(has_interest: !@book.has_interest)
      render json: { message: "Field updated successfully" }, status: :ok
    else
      render json: { errors: @book.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def register_donation
    if @book.update(donated: true)
      render json: { message: "Field updated successfully" }, status: :ok
    else
      render json: { errors: @book.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

    def set_book
      @book = Book.find(params[:book_id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Book not found' }, status: :not_found
    end

    def set_donor
      @donor = User.find(params[:user_id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Donor not found' }, status: :not_found
    end

    def book_params
      params_list = [:id, :title, :author, :resume, :year, :credit, :user_id]
      params.permit(params_list)
    end
end
