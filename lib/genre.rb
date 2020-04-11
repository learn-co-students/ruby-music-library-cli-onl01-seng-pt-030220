class Genre
  extend Concerns::Findable

  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
end

attr_accessor :name
attr_reader :songs

def initialize(name)
@name = name
@songs = []
end


def self.create(name)
song = new(name)
song.save
song
end

def save
  self.class.all << self
end

def artists
  songs.collect {|s| s.artist}.uniq
end
end