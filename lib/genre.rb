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
        genre = self.new(name)
        genre.save
        genre
        
    end

    attr_accessor :name, :songs

    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def artists
        songs.collect do |song|
            song.artist
        end.uniq
    end
end