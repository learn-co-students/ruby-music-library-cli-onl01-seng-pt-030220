require 'pry'

class Song
    attr_accessor :name

    extend Concerns::Findable

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist
        self.genre = genre
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

    def self.create(name, artist=nil, genre=nil)
        new(name, artist, genre).save
        @@all.last
    end

    def artist
        @artist
    end

    def artist=(artist)
        @artist = artist
        if @artist != nil
            artist.add_song(self)
        end
    end

    def genre
        @genre
    end

    def genre=(genre)
        @genre = genre
        if @genre != nil
            genre.add_song(self)
        end
    end
    
    #collaborating objects lab
    def self.find_by_name(name)
        self.all.find {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
    end

    def self.new_from_filename(filename)

        array = filename.split(" - ")

        song_name = array[1]
        artist_name = array[0]
        genre_name = array[2].split(".mp3").join
    
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name, artist, genre)


        # artist, song, genre_name = filename.split(" - ")
        # g_name = genre_name.gsub(".mp3", "")

        # artist = Artist.find_or_create_by_name(name)
        # genre = Genre.find_or_create_by_name(g_name)
        # new(song, artist, genre)

    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
        # song = filename.split(" - ")
        # create_song = self.create(song)
        # create_song
    end


end