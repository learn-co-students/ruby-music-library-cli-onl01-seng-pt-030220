require_relative "./Concerns/Findable.rb"


class Song 

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = [ ]

  def initialize(name, artist=nil, genre=nil)
    @name = name 
    self.artist=(artist) if artist
    self.genre=(genre) if genre
    
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
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.all
    @@all
  end 

  def self.destroy_all
    @@all.clear
  end 

  def self.create(song_name)
    new_song = Song.new(song_name)
    @@all << new_song
    return new_song 
  end 

  def self.find_by_name(name)
    all.find { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    song = find_by_name(name)
    return song ? song : self.create(name)
  end 

  def self.new_from_filename(filename)
    file_parts = filename.split(" - ")
    song_artist = file_parts[0] 
    song_name = file_parts[1]
    song_genre = file_parts[2].split(".")[0]
    new_song = find_or_create_by_name(song_name)
    new_song.artist = Artist.find_or_create_by_name(song_artist)
    new_song.genre = Genre.find_or_create_by_name(song_genre)
    new_song
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
    
  end
end 