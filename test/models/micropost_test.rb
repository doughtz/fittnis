require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save without belonging to Video" do
    comment = Micropost.new
    assert_not comment.save
  end
end
