class Artist

    @@all = []

    def self.all 
        @@all
    end 

    def self.destroy_all
        @@all.clear
    end 

    def self.create(artist)
        artist = self.new(artist)
    end 

    attr_accessor :name 
    attr_reader :songs #:musiclibrarycontroller, :musicimporter
    extend Concerns::Findable

    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def add_song(song)
        song.artist = self unless song.artist
        songs << song unless songs.include?(song)
    end

    def save
        @@all << self 
    end

    def songs 
        @songs
    end 

    def genres
        genres = self.songs.collect do |song|
          song.genre
        end
        genres.uniq
    end

end 