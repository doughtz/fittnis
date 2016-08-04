require 'test_helper'

class VideosCreatedTest < ActionDispatch::IntegrationTest

test "invalid video information" do
    get upload_path
    assert_no_difference 'Video.count' do
      post videos_path, video: { user_id:  "",
                               title: "user@invalid",
                               description:              "foo",
                               equipment: "bar",
                               length: 123,
                               tags:              "foo",
                               videofile: ["bar"],
                               rating: 123,
                               categor:              "foo",
        
      }
    end
    assert_template 'videos/new'
=begin **this is not being used currently
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
=end

  end

  test "valid video creation information" do
    get upload_path
    assert_difference 'Video.count', 1 do
      post videos_path, video: { user_id:  1654,
                               title: "user@invalid",
                               description:              "foo",
                               equipment: "bar",
                               length: 123,
                               tags:              "foo",
                               videofile: "bar",
                               rating: 123,
                               categor:              "foo",
        
      }
    end
    @video = assigns(:video)
    #make sure these bottom two lines get uncommented at some point
    # assert_template 'users/show'
    # assert is_logged_in?
  end
end
