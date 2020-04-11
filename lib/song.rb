class Song
  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    s = new(name)
    s.save
    s
  end

  def self.find_by_name(name)
    @@all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || Song.create(name)
  end

  def self.new_from_filename(filename)
    file = filename.split(" - ")
    artist_name = file[0]
    song_name = file[1]
    song_genre = file[2].split(".")[0]

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(song_genre)
    song = Song.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    @@all << Song.new_from_filename(filename)
  end

  attr_reader :name, :artist, :genre

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
  end

  def name=(name)
    @name = name
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs.include?(self) || genre.songs << self
  end

  def save
    @@all << self
  end

end