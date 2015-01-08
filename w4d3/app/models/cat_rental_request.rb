# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#

class CatRentalRequest < ActiveRecord::Base

  after_initialize do |cat_rental_request|
    cat_rental_request.status ||= "PENDING"
  end

  validates :cat_id, :start_date, :end_date, :user_id, presence: true
  validates_inclusion_of :status, in: %w(PENDING APPROVED DENIED), allow_nil: true
  validate :overlapping_approved_requests

  belongs_to :cat
  belongs_to :user

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

  private

  def overlapping_requests
    CatRentalRequest
      .where("(:id IS NULL) OR (id != :id)", id: self.id)
      .where(cat_id: cat_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
         NOT( (start_date > :end_date) OR (end_date < :start_date) )
      SQL
  end

  def overlapping_approved_requests
    overlapproved = overlapping_requests.select { |req| req.status == 'APPROVED' }
    return if overlapproved.empty? || status == "DENIED"
    errors[:start_date] << "date overlaps with another cat's date"
  end

  def overlapping_pending_requests
    overlapping_requests.select { |req| req.status == 'PENDING' }
  end

  def verify_authorized
    @cat = Cat.find(params[:id])
    redirect_to cat_url(@cat) if current_user.id = @cat.owner.id
    #TODO, figure out if this creates repeat queries
  end
end
