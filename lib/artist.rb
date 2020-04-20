require_relative 'concerns/findable'
class Artist
  attr_accessor :name

  extend Concerns::Findable



  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

 def self.create(name)
    new_artist = new(name)
    new_artist.save
    new_artist
  end

  def self.destroy_all
    @@all.clear
  end

  def add_song(song)
    if !song.artist
      song.artist = self
    end
    @songs << song unless @songs.include?(song)
  end

  def songs
    @songs
  end

  def genres
    collection = []
    @songs.each do |song|
      collection << song.genre unless collection.include?(song.genre)
    end
    collection
  end
end