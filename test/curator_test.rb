require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'

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

  def test_it_can_add_photographs
    curator = Curator.new
    photo_1 = {
                id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              }
    photo_2 = {
                id: "2",
                name: "Moonrise, Hernandez",
                artist_id: "2",
                year: "1941"
              }
    curator.add_photograph(photo_1)
    assert_instance_of Photograph, curator.photographs[0]
    assert_equal 1, curator.photographs.count
    curator.add_photograph(photo_2)
    assert_equal 2, curator.photographs.count
    assert_equal "2", curator.photographs[1].id
  end

  def test_it_can_add_artists
    curator = Curator.new
    artist_1 = {
                id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"
               }
    artist_2 = {
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
               }
    curator.add_artist(artist_1)
    assert_instance_of Artist, curator.artists[0]
    assert_equal 1, curator.artists.count
    curator.add_artist(artist_2)
    assert_equal 2, curator.artists.count
    assert_equal "1902", curator.artists[1].born
  end

  def test_it_can_find_artist_by_id
    curator = Curator.new
    artist_1 = {
                id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"
               }
    artist_2 = {
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
               }
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    actual = curator.find_artist_by_id("1")
    assert_instance_of Artist, actual
    assert_equal "Henri Cartier-Bresson", actual.name
  end



end
