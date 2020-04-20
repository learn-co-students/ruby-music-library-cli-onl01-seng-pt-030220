require_relative 'concerns/findable'
class Genre
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
    new_genre = new(name)
    new_genre.save
    new_genre
  end

  def self.destroy_all
    @@all.clear
  end

  def songs
    @songs
  end

  def artists
    collection = []
    @songs.each do |song|
      collection << song.artist unless collection.include?(song.artist)
    end
    collection
  end
end