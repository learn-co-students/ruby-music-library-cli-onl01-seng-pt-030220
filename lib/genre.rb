require_relative '../config/environment'

class Genre 

    @@all = []

    def self.all 
        @@all 
    end 

    def self.destroy_all 
        @@all.clear 
    end

    def self.create(name)
        new(name).save 
        @@all.last
    end

    extend Concerns::Findable
    attr_accessor :name 

    def initialize(name)
        @name = name 
        @songs = []
    end

    def songs 
        @songs 
    end 

    def artists 
        @songs.map(&:artist).uniq
    end 

    def save
        @@all << self 
    end 

end 