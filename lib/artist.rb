class Artist
    extend Concerns::Findable
    
    @@all = []

    def self.all
        @@all 
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(artist)
     artist = new(artist)
     artist.save
     artist
    end

    attr_accessor :name
    attr_reader :songs

    def initialize(name)
        @name = name
        @songs = []

    end

    def save
       self.class.all << self
    end
    
    def add_song(song)
        song.artist = self unless song.artist 
        songs.push song unless songs.include?(song)
    end

    def genres
        songs.collect(&:genre).uniq
    end

    
end