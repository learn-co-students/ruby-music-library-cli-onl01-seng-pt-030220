class Artist
  extend Concerns::Findable
  extend Persistable::ClassMethod
  include Persistable::InstanceMethod

  attr_accessor :name, :songs 

  @@all = [ ]

  def initialize(name)
    @name = name
    @songs = [ ]     
  end

  def self.all
    @@all
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