class Api::V1::Donation::Index
  prepend SimpleCommand

  def initialize(user_id)
    @donor_id = user_id
    @response = {}
  end

  def call
    @response[:donations] = get_donations
    @response[:total_completed] = total_donations_completed
    @response[:total_pending] = total_donations_pending

    @response
  end

  def get_donations
    Donation.joins(:book, :receiver).where.not(status: "canceled")
                                    .select('donations.*, 
                                             books.user_id as donor_id')
  end

  def total_donations_completed
    Donation.joins(:book, :receiver).where(donations: { status: 'completed' }).count
  end

  def total_donations_pending
    Donation.joins(:book, :receiver).where(donations: { status: 'processing' }).count
  end
end
  