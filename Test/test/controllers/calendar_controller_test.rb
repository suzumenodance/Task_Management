require 'test_helper'

class CalendarControllerTest < ActionDispatch::IntegrationTest
  test "should get Main" do
    get calendar_Main_url
    assert_response :success
  end

end
