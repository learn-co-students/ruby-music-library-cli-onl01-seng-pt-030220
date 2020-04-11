require 'pry'

class Genre

    extend Concerns::Findable

    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def save 
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        new(name).save
        @@all.last
    end

    def add_song(song)
        song.genre = self if !song.genre
        @songs << song if !@songs.include?(song)
    end
   
    #has many through
    def artists
        @songs.map(&:artist).uniq
    end

    
end