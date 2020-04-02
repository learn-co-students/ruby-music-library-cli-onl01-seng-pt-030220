require 'pry'
#comment change
class Artist

    extend Concerns::Findable

    attr_accessor :name

    @@all = []

    def self.all
        @@all
    end
    
    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        self.class.all << self
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        instance = self.new(name)
        instance.save
        instance
    end

    def songs
        @songs
    end

    def add_song(song)
        if song.artist != self
            song.artist = self
        end
        if !songs.include?(song)
            songs << song
        end
    end

    def genres
        my_genres = songs.collect { |song| song.genre}
        my_genres.uniq
    end
    
end