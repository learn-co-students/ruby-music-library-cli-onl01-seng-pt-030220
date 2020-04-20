require_relative 'concerns/findable'
class Song
  attr_accessor :name, :artist, :genre

  extend Concerns::Findable

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name, artist = nil, genre = nil)
    new_song = new(name, artist, genre)
    new_song.save
    new_song
  end

  def self.destroy_all
    @@all.clear
  end

  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    @genre.songs << self unless @genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    split_file = filename.split(" - ")
    song = self.find_or_create_by_name(split_file[1])
    artist = Artist.find_or_create_by_name(split_file[0])
    genre = Genre.find_or_create_by_name(split_file[2].split(".mp3")[0])
    song.artist = artist
    song.genre = genre
    song
  end

  def self.create_from_filename(filename)
    new_song = new_from_filename(filename)
    new_song.save
  end
end