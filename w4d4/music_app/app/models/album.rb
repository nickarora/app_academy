# == Schema Information
#
# Table name: albums
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  recording_type :string           not null
#  band_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Album < ActiveRecord::Base

	RECORDING_TYPES = ['live', 'studio']
	validates :name, :recording_type, :band, presence: true
	validates_inclusion_of :recording_type, in: RECORDING_TYPES
	belongs_to :band
	has_many :tracks, dependent: :destroy

end
