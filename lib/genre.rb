require 'pry'

class Genre

    extend Concerns::Findable

    attr_accessor :name

    @@all = []

    def self.all
        @@all
    end
    
    def initialize(name)
        @name = name
        @songs = []
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

    def songs
        @songs
    end

    def artists
        my_artists = songs.collect { |song| song.artist}
        my_artists.uniq
    end


end