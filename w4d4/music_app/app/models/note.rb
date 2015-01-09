# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  user_id    :integer          not null
#  track_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Note < ActiveRecord::Base
	
	validates :content, :track, :user, presence: true
	belongs_to :track
	belongs_to :user

end
