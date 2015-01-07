class CatRentalRequest < ActiveRecord::Base

  after_initialize do |cat_rental_request|
    cat_rental_request.status ||= "PENDING"
  end

  validates :cat_id, :start_date, :end_date, presence: true
  validates_inclusion_of :status, in: %w(PENDING APPROVED DENIED), allow_nil: true
  validate :overlapping_approved_requests

  belongs_to :cat

  def approve!
    CatRentalRequest.transaction do
      self.update(status: "APPROVED")
      overlapping_pending_requests.each { |req| req.deny! }
    end
  end

  def deny!
    self.update(status: "DENIED")
  end

  def pending?
    status == "PENDING"
  end

  def approved?
    status == "APPROVED"
  end

  # private

  def overlapping_requests
    CatRentalRequest
      .where("(:id IS NULL) OR (id != :id)", id: self.id)
      .where(cat_id: cat_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
       NOT( (start_date > :end_date) OR (end_date < :start_date) )
    SQL

    # CatRentalRequest.find_by_sql(<<-SQL)
    # SELECT
    #   crr.*
    # FROM
    #   cat_rental_requests crr
    # WHERE
    #   crr.cat_id = #{cat_id} AND
    #   (
    #     (crr.start_date BETWEEN TO_DATE ('#{start_date}', 'yyyy-mm-dd') AND TO_DATE ('#{end_date}', 'yyyy-mm-dd' )) OR
    #     (crr.end_date BETWEEN TO_DATE ('#{start_date}', 'yyyy-mm-dd') AND TO_DATE ('#{end_date}', 'yyyy-mm-dd')) OR
    #     (
    #       crr.start_date <= TO_DATE ('#{start_date}', 'yyyy-mm-dd') AND
    #       crr.end_date >= TO_DATE ('#{end_date}', 'yyyy-mm-dd')
    #     )
    #   )
    # SQL
  end

  def overlapping_approved_requests
    overlapproved = overlapping_requests.select { |req| req.status == 'APPROVED' }
    return if overlapproved.empty? || status == "DENIED"
    errors[:start_date] << "date overlaps with another cat's date"
  end

  def overlapping_pending_requests
    overlapping_requests.select { |req| req.status == 'PENDING' }
  end

end
