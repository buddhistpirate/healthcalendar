require 'minitest/autorun'
require_relative '../health_calendar'


class TestHealthCalendar < Minitest::Test
  attr_reader :health_calendar

  def setup
    @health_calendar = HealthCalendar.new
  end

  def test_connect_to_runkeeper
    health_calendar.connect_to_runkeeper()
    activites_response = health_calendar.activities
    assert_equal activites_response.size, 0
  end
end
