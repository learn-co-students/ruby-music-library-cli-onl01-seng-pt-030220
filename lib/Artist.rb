require_relative "./Concerns/Findable.rb"


class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs 

  @@all = [ ]

  def initialize(name)
    @name = name
    @songs = [ ]     
  end

  def self.all
    @@all
  end 

  def self.destroy_all
    @@all.clear
  end 

  def self.create(artist_name)
    new_artist = Artist.new(artist_name)
    new_artist.save
    return new_artist
  end 

  def save
    @@all << self
  end 

  def add_song(song)
      songs << song unless songs.include?(song)
    if song.artist == nil 
       song.artist = self 
    end 
    return song.artist
  end

  def genres
    songs.map { |song| song.genre }.uniq
  end



end 