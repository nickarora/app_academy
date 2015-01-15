# == Schema Information
#
# Table name: postsubs
#
#  id         :integer          not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Postsub < ActiveRecord::Base

  validates :sub, :post, presence: true
  belongs_to :post
  belongs_to :sub

end
