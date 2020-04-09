class Genre
    extend Concerns::Findable
    attr_accessor :name, :song

    @@all = []

    #Instance Methods
    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def songs
        @songs
    end

    def artists
        songs.collect{|a| a.artist}.uniq
    end

    #Class Methods
    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        genre = Genre.new(name)
        genre.save
        genre
    end
end