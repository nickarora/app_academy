# == Schema Information
#
# Table name: session_tokens
#
#  id         :integer          not null, primary key
#  token      :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SessionTokenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
