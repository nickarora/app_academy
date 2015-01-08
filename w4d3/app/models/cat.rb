# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#

class Cat < ActiveRecord::Base

  COLORS = ['grey', 'orange', 'white', 'black', 'tabby', 'brown']

  validates :user_id, :birth_date, :color, :name, :sex, :description, presence: true
  validates_inclusion_of :sex, in: %w( M F )
  validates_inclusion_of :color, in: COLORS

  has_many :cat_rental_requests, dependent: :destroy
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year - (birth_date.change(:year => now.year) > now ? 1 : 0)
  end

  def not_denied_requests
    cat_rental_requests.where("status != 'DENIED'").order(:start_date)
  end

end
