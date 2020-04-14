require 'pry'
class Artist
  extend Concerns::Findable
  
  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    a = new(name)
    a.save
    a
  end

  attr_accessor :name

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def songs
    @songs
  end

  def add_song(song)
     song.artist || song.artist = self
    @songs.include?(song) || @songs << song
  end

  def genres
    @songs.collect { |song| song.genre }.uniq
  end

end