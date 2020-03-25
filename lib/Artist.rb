class Artist
  attr_accessor :name, :songs
  extend Concerns::Findable

  @@all = []
  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save

    @@all << self
  end

  def self.create(name)
    artist = Artist.new(name)
    @@all << artist
    artist
  end

  def genres
    arr = []
    songs.each do |song|
      if !arr.include?(song.genre)
        arr << song.genre
      end
    end
    arr
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    if !@songs.include?(song)
        @songs << song
      end
  end

end
