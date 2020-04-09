require_relative '../config/environment'
require 'pry'

class Artist 

    @@all = []

    def self.all 
        @@all 
    end

    def self.create(name)
        new(name).save
        @@all.last
    end

    def self.destroy_all 
        @@all.clear 
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

    def add_song(song)
        song.artist = self if !song.artist 
        @songs << song if !@songs.include?(song)
    end

    def genres
        # genre_list = []
        # @songs.each do |song|
        #     if !genre_list.include?(song.genre)
        #         genre_list << song.genre 
        #     end 
        # end
        # genre_list
        @songs.map(&:genre).uniq
    end 

    def save 
        @@all << self 
    end 

end 