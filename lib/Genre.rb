class Genre
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

  def artists
    songs.map { |song| song.artist }.uniq
  end
end 