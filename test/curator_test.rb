require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/photograph'

class CuratorTest < MiniTest::Test

  def test_it_exists
    curator = Curator.new
    assert_instance_of Curator, curator
  end

  def test_it_starts_without_artists_or_photographs
    curator = Curator.new
    assert_equal [], curator.artists
    assert_equal [], curator.photographs
  end
end
