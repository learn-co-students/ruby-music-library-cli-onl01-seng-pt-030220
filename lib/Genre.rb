class Genre

    extend Concerns::Findable

    @@all = []

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(genre_name)
        new_genre = Genre.new(genre_name)
        new_genre.save
        new_genre
    end

    attr_accessor :name
    attr_reader :songs, :artist

    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def artists
        self.songs.map {|song| song.artist}.uniq
    end

end