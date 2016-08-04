require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @video = @user.videos.build(title: "Lorem ipsum", description: "This is description", 
                       length: 12, tags: "These are tags", equipment: "dumbbells", videofile: "www.videos.com", 
                       rating: "4", categor: "Stretching", user_id: @user.id)
  end

  test "should be valid" do
    assert @video.valid?
  end

  test "user id should be present" do
    @video.user_id = nil
    assert_not @video.valid?
  end
  
  test "title should be present" do
    @video.title = "   "
    assert_not @video.valid?
  end

  test "content should be at most 100 characters" do
    @video.title = "a" * 101
    assert_not @video.valid?
  end
  
  test "description should be present" do
    @video.description = "   "
    assert_not @video.valid?
  end

  test "content should be at most 4000 characters" do
    @video.description = "a" * 4001
    assert_not @video.valid?
  end
  
  test "length should be present" do
    @video.length = "   "
    assert_not @video.valid?
  end
  
  test "tags should be present" do
    @video.tags = "   "
    assert_not @video.valid?
  end
  
  test "equipment should be present" do
    @video.equipment = "   "
    assert_not @video.valid?
  end
  
  test "videofile should be present" do
    @video.videofile = "   "
    assert_not @video.valid?
  end
  
  test "rating should be present" do
    @video.rating = "   "
    assert_not @video.valid?
  end
  
  test "categor should be present" do
    @video.categor = "   "
    assert_not @video.valid?
  end
  
  test "order should be most recent first" do
    assert_equal videos(:most_recent), Video.first
  end
end
