# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  version    :string           not null
#  lyrics     :text
#  album_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base

	VERSIONS = ['regular', 'bonus']
	validates :name, :version, :album, presence: true
	validates_inclusion_of :version, in: VERSIONS
	belongs_to :album
	has_many :notes, dependent: :destroy

end
