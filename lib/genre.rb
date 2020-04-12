class Genre
    extend Concerns::Findable

    attr_accessor :name, :songs

    @@all = []

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        self.new(name).save
        @@all.last
    end

    def initialize(name)
        @name = name
        @songs = []
    end
    
    def save
        @@all << self
    end

    def artists
        songs.map {|song| song.artist}.uniq
    end
end