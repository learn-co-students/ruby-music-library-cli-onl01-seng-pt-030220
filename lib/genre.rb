class Genre
  extend Concerns::Findable

  @@all = []
  attr_accessor :name, :song, :artist

  def initialize(name)
    @name = name
    @songs = []
    save
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end
  # binding.pry

  def songs
    @songs
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.genre = self unless song.genre
  end

  def artists
    songs.collect {|song| song.artist}.uniq # not song.genre.uniq
  end

end
