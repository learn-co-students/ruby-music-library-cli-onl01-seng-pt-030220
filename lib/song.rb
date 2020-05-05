require "pry"
# require_relative "./musicimporter.rb"

class Song
  extend Concerns::Findable # Take all of the methods in the Findable module and add them as class methods

  @@all = []
  attr_accessor :name, :artist, :genre

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def save
    @@all << self
  end

  def self.all #Class Reader
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song

    # self.new.tap do |o|
    #   o.name = name
    # end
    # This following code is the same above
    # i = self.new
    # i.name = name
    # i
  end

  def artist=(artist)
    @artist = artist #<Artist0x00bb @name="", @songs=[]>
    artist.add_song(self) #<Artist0x00bb @name="", @songs=[#<Song:0x000055a7f962eb38 @name="New Light", @artist=#<Artist:0x00bb]>
  end
  #=> #<Artist:0x0000560d3bdbda78 @name="John Legend", @songs=[#<Song:0x0000560d3bdbdac8 @name="New Light", @artist=#<Artist:0x0000560d3bdbda78 ...>>]>

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.new_from_filename(filename)
    filename = filename.gsub(".mp3", "")
    file_array = filename.split(" - ")
    name, artist, genre = file_array[1], file_array[0], file_array[2]
    # equal to artist, name, genre = filename.split(" - ")

    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)

    self.new(name, artist, genre)

  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap {|song| song.save}
    # equal to new_from_filename(filename).save
  end

end
