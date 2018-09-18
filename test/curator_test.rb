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
    assert_nil curator.find_artist_by_id("3")

  end

  def test_it_can_find_photograph_by_id
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
    curator.add_photograph(photo_2)

    actual = curator.find_photograph_by_id("2")

    assert_instance_of Photograph, actual
    assert_equal "Moonrise, Hernandez", actual.name
    assert_nil curator.find_photograph_by_id("3")
  end

  def test_it_can_find_photographs_by_artist
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
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
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
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    diane_arbus = curator.find_artist_by_id("3")

    actual = curator.find_photographs_by_artist(diane_arbus)

    assert_instance_of Photograph, actual[0]
    assert_equal 2, actual.count
    assert_equal [], curator.find_photographs_by_artist("Ryan")
  end

  def test_it_can_find_artists_with_multiple_photographs
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
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
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
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    actual = curator.artists_with_multiple_photographs

    assert_instance_of Artist, actual[0]
    assert_equal 1, actual.length
    assert_equal "Diane Arbus", actual[0].name
  end

  def test_it_can_find_photos_taken_by_an_artist_from_a_place
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
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
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
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    actual = curator.photographs_taken_by_artists_from("United States")

    assert_instance_of Photograph, actual[0]
    assert_equal 3, actual.count
    assert_equal "Moonrise, Hernandez", actual[0].name
    assert_equal [], curator.photographs_taken_by_artists_from("Ryan's House")
  end

  def test_it_can_load_photographs
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')

    assert_equal 4, curator.photographs.count
    assert_instance_of Photograph, curator.photographs[0]
  end

  def test_it_can_load_artists
    curator = Curator.new
    curator.load_artists('./data/artists.csv')

    assert_equal 6, curator.artists.count
    assert_instance_of Artist, curator.artists[0]
  end

  def test_it_can_find_photos_taken_between_years
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')

    range = (1950..1965)
    actual = curator.photographs_taken_between(range)
    assert_equal 2, actual.count
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", actual[0].name
    assert_equal [], curator.photographs_taken_between(2001..2002)
  end

  def test_it_can_find_artists_photos_by_age
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    curator.load_artists('./data/artists.csv')

    diane_arbus = curator.find_artist_by_id("3")

    expected = {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}
    actual = curator.artists_photographs_by_age(diane_arbus)
    assert_equal expected, actual
  end
end
