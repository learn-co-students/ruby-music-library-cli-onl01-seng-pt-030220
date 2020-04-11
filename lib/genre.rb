class Genre
  extend Concerns::Findable
  
  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    g = new(name)
    g.save
    g
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

  def artists
    @songs.collect {|song| song.artist }.uniq
  end

end