require 'pry'
class Artist

    extend Concerns::Findable 
    
    @@all = []

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end

    attr_accessor :name, :songs

    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def add_song(song)
        if song.artist != self
            song.artist = self
        end
        if !@songs.include?(song)
            @songs << song
        end
    end

    def genres
        songs.collect do |song|
            song.genre
        end.uniq
    end
end

