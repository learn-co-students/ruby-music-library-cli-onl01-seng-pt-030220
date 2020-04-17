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
     self.new(genre_name)
    end

    attr_accessor :name
    attr_reader :songs

    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def save
       @@all <<  self
    end

    def artists
        songs.collect(&:artist).uniq
    end

end