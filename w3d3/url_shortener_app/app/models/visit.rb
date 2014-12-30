class Visit < ActiveRecord::Base
  validates :visited_url_id, :user_id, :presence => true

  def self.record_visit!(user, shortened_url)
    self.create!(
      :visited_url_id => shortened_url.id,
      :user_id => user.id
    )
  end

  belongs_to(
    :visitor,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :visited_url,
    class_name: 'ShortenedUrl',
    foreign_key: :visited_url_id,
    primary_key: :id
  )

end
