class Song
  attr_accessor :name, :artist, :genre
  extend Concerns::Findable
  @@all = []

  def initialize(name, artist=nil, genre = nil)
    @name = name
      self.artist = artist if artist != nil
      self.genre = genre if genre != nil
      self.artist.genres << genre if artist != nil && genre != nil && !self.artist.genres.include?(genre)
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
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    if !@genre.songs.include?(self)
      @genre.songs << self
    end
  end
  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    song_instance = nil
    @@all.each do |song|
      song_instance = song if song.name == name
    end
    song_instance
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
       self.create(name)
     else
       self.find_by_name(name)
    end
  end

  def self.new_from_filename(file)
    arr = file.split(' - ')
    song = self.new(arr[1])
    song.artist = Artist.find_or_create_by_name(arr[0])
    song.genre = Genre.find_or_create_by_name(arr[2].delete_suffix('.mp3'))
    song
  end

  def self.create_from_filename(file)
  self.new_from_filename(file).save
  end
end
