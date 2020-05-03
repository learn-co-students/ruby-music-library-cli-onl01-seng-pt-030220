class Artist
  extend Concerns::Findable

  @@all = []
  attr_accessor :name, :genre

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
    artist = self.new(name)
    artist.save
    artist
    # binding.pry
  end

  def songs
    @songs
    # Song.all.select {|song| song.artist == self}
  end

  def add_song(song) # mayor.add_song(new_light)
    @songs << song unless @songs.include?(song) #does not add the song to the current artist's collection of songs if it already exists therein
#does not assign the artist if the song already has an artist
    song.artist = self unless song.artist
    #=> #<Artist:0x000055a7f962ebb0 @name="John Mayor", @song=[#<Song:0x000055a7f962eb38 @name="New Light", @artist=#<Artist:0x000055a7f962ebb0 ...>>]>
  end

  def genres
    songs.collect {|song| song.genre}.uniq # not song.genre.uniq
  end

end
