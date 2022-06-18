class Api::V1::Donation::Informations
  prepend SimpleCommand

  def initialize(user_id)
    @donor_id = user_id
  end

  def call  
    response = {
      user_donations: query_user_donations,
      user_receipts: query_user_receipts,
      total_completed: total_user_donations_completed,
      total_pending: total_user_donations_pending,
      total_received_completed: total_donations_received_user_completed,
      total_received_pending: total_donations_received_user_pending,
    }

    response
  end

  def total_user_donations_completed
    User.joins(books: :donation)
        .where(users: { id: @donor_id })
        .where(donations: { status: 'completed'})
        .count
  end

  def total_user_donations_pending
    User.joins(books: :donation)
        .where(users: { id: @donor_id })
        .where(donations: { status: 'processing'})
        .count
  end

  def total_donations_received_user_completed
    User.joins(books: :donation)
        .where(donations: { status: 'completed', receiver_id: @donor_id })
        .count
  end

  def total_donations_received_user_pending
    User.joins(books: :donation)
        .where(donations: { status: 'processing', receiver_id: @donor_id })
        .count
  end

  def query_user_donations
    User.joins(books: :donation)
        .joins("INNER JOIN users AS receivers ON receivers.id = donations.receiver_id")
        .where(users: { id: @donor_id })
        .where.not(donations: { status: 'canceled' })
        .order('donations.status DESC')
        .select(
          "donations.id AS donation_id",
          "donations.status",
          "donations.date_delivery",
          "donations.receiver_id",
          "donations.donor_evaluation",
          "donations.receiver_evaluation",
          "donations.donor_note",
          "donations.receiver_note",
          "books.id AS book_id",
          "books.credit",
          "books.title AS book_title",
          "books.user_id AS donor_id",
          "users.name AS name_donor",
          "receivers.name AS name_receiver",
          "donations.created_at",
          "donations.updated_at",
          "receivers.phone AS receiver_phone"
        )
  end

  def query_user_receipts
    User.joins(books: :donation)
        .joins("INNER JOIN users AS receivers ON receivers.id = donations.receiver_id")
        .where(donations: { receiver_id: @donor_id })
        .where.not(donations: { status: 'canceled' })
        .order('donations.status DESC')
        .select(
          "donations.id AS donation_id",
          "donations.status",
          "donations.date_delivery",
          "donations.receiver_id",
          "donations.donor_evaluation",
          "donations.receiver_evaluation",
          "donations.donor_note",
          "donations.receiver_note",
          "books.id AS book_id",
          "books.credit",
          "books.title AS book_title",
          "books.user_id AS donor_id",
          "users.name AS name_donor",
          "receivers.name AS name_receiver",
          "donations.created_at",
          "donations.updated_at",
          "users.phone AS donor_phone"
        )
  end
end
  