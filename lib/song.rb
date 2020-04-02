require 'pry'

class Song

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def self.all
        @@all
    end
    
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist
        self.genre = genre

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

    def artist=(artist)
        @artist = artist
        if artist != nil
            artist.add_song(self)
        end
    end

    def genre=(genre)
        @genre = genre
        if genre != nil
            if !genre.songs.include?(self)
                genre.songs << self
            end
        end
    end
    
    def self.find_by_name(name)
        self.all.find { |song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        if self.find_by_name(name) == nil
            self.create(name)
        else
            self.find_by_name(name)
        end
    end

    def self.new_from_filename(filename)
        attributes = filename.split(" - ")
        artist = attributes[0]
        name = attributes[1]
        genre = attributes[2].split(".")[0]
        self.new(name, Artist.find_or_create_by_name(artist), Genre.find_or_create_by_name(genre))
    end

    def self.create_from_filename(filename)
        instance = self.new_from_filename(filename)
        instance.save
    end

end

Song.create("james")