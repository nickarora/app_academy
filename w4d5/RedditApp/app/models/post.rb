# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author, presence: true

  belongs_to :author,
      class_name:  :User,
      foreign_key: :author_id,
      primary_key: :id

  has_many :postsubs, dependent: :destroy

  has_many :subs, through: :postsubs, source: :sub
end
