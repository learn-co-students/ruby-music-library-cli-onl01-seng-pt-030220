class Artist

    extend Concerns::Findable

    @@all = []

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(artist_name)
        new_artist = Artist.new(artist_name)
        new_artist.save
        new_artist
    end

    attr_accessor :name, :songs
    # attr_reader :songs

    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def add_song(song)
        song.artist == self ? song.artist : song.artist = self
        self.songs << song unless self.songs.include?(song)
    end

    def genres
        self.songs.map {|song| song.genre}.uniq
    end

end