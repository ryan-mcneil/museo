require './lib/photograph'
require './lib/artist'
require './lib/file_io'
require 'pry'

class Curator
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(data)
    photo = Photograph.new(data)
    @photographs << photo
  end

  def add_artist(data)
    artist = Artist.new(data)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photograph|
      photograph.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      @artists.include?(artist) && photograph.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      find_photographs_by_artist(artist).count > 1
    end
  end

  def photographs_taken_by_artists_from(country)
    @artists.inject([]) do |photos, artist|
      if artist.country == country
        photos << find_photographs_by_artist(artist)
      end
      photos
    end.flatten
  end

  def load_photographs(file)
    photo_data = FileIO.load_photographs(file)

    photo_data.each do |data|
      add_photograph(data)
    end
  end

  def load_artists(file)
    artist_data = FileIO.load_artists(file)

    artist_data.each do |data|
      add_artist(data)
    end
  end

  def photographs_taken_between(range)
    @photographs.find_all do |photo|
      range.include?(photo.year.to_i)
    end
  end

  def artists_photographs_by_age(artist)
    artist_photos = find_photographs_by_artist(artist)
    artist_photos.inject(Hash.new("")) do |hash, photograph|
      age = photograph.year.to_i - artist.born.to_i
      hash[age] = photograph.name
      hash
    end
  end

end
