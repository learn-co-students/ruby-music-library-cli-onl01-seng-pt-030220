require_relative "./Concerns/Findable.rb"

class Genre
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

  def self.create(genre_name)
    new_genre = Genre.new(genre_name)
    new_genre.save
    return new_genre
  end 

  def save
    @@all << self
  end

  def artists
    songs.map { |song| song.artist }.uniq
    
  end
end 