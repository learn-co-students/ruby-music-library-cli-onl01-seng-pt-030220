require_relative "../lib/concerns/findable"


class Artist
    extend Concerns::Findable
    attr_accessor :name, :song
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        new_artist = Artist.new(name)
        new_artist.save
        new_artist
    end

    def songs
        @songs
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self 
        end

        if @songs.include?(song) == false
            @songs << song
        end
        
    end

    def genres
        artist_genres = songs.map do |song|
            song.genre
        end
        artist_genres.uniq
    end
end