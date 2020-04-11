require 'pry'
class Genre 
    extend Concerns::Findable
    
    @@all = [] 

    def self.all 
        @@all
    end

    def self.destroy_all 
        @@all.clear 
    end

    def self.create(name)
        new_genre = self.new(name)
    end 

    attr_accessor :name

    def initialize(name) 
        @name = name 
        save
        @songs = []
    end

    def save 
        @@all << self 
    end 

    def songs 
    @songs
    end 

    def artists
    artist_array = [] 
    #returns a collection of artists for all of the genre's songs (genre has many artists through songs) (FAILED - 1)
    songs.each do |a|
        artist_array << a.artist 
    end
    artist_array.uniq
    end

end