#require 'pry'

class Song

  @@all = []

  attr_reader :artist, :genre
  attr_accessor :name


  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist=(artist) if artist != nil
    self.genre=(genre) if genre != nil
    #save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    @@all << self
  end

  def self.create(song)
    song = new(song)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)
    filename = filename.split(" - ")
    artist = filename[0]
    song = filename[1]
    genre = filename[2].gsub( ".mp3" , "")

    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)
    song = Song.new(song, artist, genre)
  end

  def self.create_from_filename(filename)
    @@all << Song.new_from_filename(filename)
  end
#binding.pry
end
