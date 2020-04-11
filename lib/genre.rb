require_relative "../lib/concerns/findable"

class Genre
    extend Concerns::Findable

    attr_accessor :name 
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
        new_genre = Genre.new(name)
        new_genre.save
        new_genre
    end

    def songs
        @songs
    end

    def artists
       genre_artists = songs.map do |song|
            song.artist
        end
        genre_artists.uniq
    end
end