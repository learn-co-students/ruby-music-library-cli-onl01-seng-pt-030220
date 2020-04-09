require_relative '../config/environment'

class Song

    @@all = []

    def self.all 
        @@all 
    end

    def self.create(name, artist=nil, genre=nil)
        new(name, artist, genre).save
        @@all.last
    end 

    def self.new_from_filename(filename)
        file = filename.split(" - ") # ["Tyler the Creator", "Yonkers", "Hip-Hop"] - [artist, song, genre]
        song, artist, genre = file[1], file[0], file[2].gsub(".mp3", "")
        find_artist = Artist.find_or_create_by_name(artist)
        find_genre = Genre.find_or_create_by_name(genre)
        new(song, find_artist, find_genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end

    def self.destroy_all 
        @@all.clear 
    end

    def self.find_by_name(name)
        self.all.detect {|song| song.name == name}
    end 

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    attr_accessor :name
    attr_reader :artist, :genre

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist != nil 
        self.genre = genre if genre != nil 
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

end 