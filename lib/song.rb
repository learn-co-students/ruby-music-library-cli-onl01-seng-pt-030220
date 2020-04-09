require 'pry'

class Song
    attr_accessor :name, :artist, :genre

    @@all = []

    #Instance Methods
    def initialize(name, artist= nil, genre= nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def save
        @@all << self
    end

    #Class Methods
    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    def self.find_by_name(name)
        all.detect{ |song| song.name == name }
    end
    
    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(filename)
        file = filename.split(" - ") #Adele - Rolling In the Deep - folk.mp3
        artist, song , genre =  file[0], file[1], file[2].gsub(".mp3","")

        find_artist = Artist.find_or_create_by_name(artist)
        find_genre = Genre.find_or_create_by_name(genre)

        new(song, find_artist, find_genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end
end
