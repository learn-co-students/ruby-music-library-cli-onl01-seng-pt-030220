class Artist
  
  extend Concerns::Findable
  extend Persistable::ClassMethod
  extend Nameable::ClassMethod
  include Persistable::InstanceMethod

  attr_accessor :name
  attr_reader :songs 

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
    return song.artist = self if song.artist == nil 
  end

  def genres
    songs.map { |song| song.genre }.uniq
  end
end 