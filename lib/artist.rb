class Artist

  extend Concerns::Findable

  @@all = []

  attr_accessor :name, :genre


  def initialize(name)
    @name = name
    @songs = []
    save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    name = self.new(name)
    name.save
    name
  end

  def songs
    @songs
  end

  def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end

  def genres
    self.songs.map {|song| song.genre}.uniq
  end

end
