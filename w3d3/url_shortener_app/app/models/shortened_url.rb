class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, :submitter_id, :presence => true
  validates :short_url, :uniqueness => true

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :visited_url_id,
    primary_key: :id
  )

  has_many(
  :unique_visits,
  Proc.new { distinct },
  class_name: 'Visit',
  foreign_key: :visited_url_id,
  primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  def self.random_code
    code = nil
    while code.nil? || self.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!(
      :short_url => self.random_code,
      :long_url => long_url,
      :submitter_id => user.id
    )
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    # Visit.where("visited_url_id = ?", "#{self.id}").select("user_id").distinct.count
    visitors.count
  end

  def num_recent_uniques
    # Visit.where("visited_url_id = ?", "#{self.id}").where("created_at >= ?", 10.minutes.ago).select("user_id").distinct.count
    unique_visits.where("created_at >= ?", 10.minutes.ago).count
  end



end
