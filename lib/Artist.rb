require "pry"
class Artist 
    extend Concerns::Findable

    @@all = [] 

    def self.all 
        @@all 
    end 
    
    def self.destroy_all 
        @@all.clear 
    end 

    def self.create(name)
        new_artist = self.new(name) 
    end

    attr_accessor :name 

def initialize(name) 
    @name = name 
    @songs = []
    save
end 

def save 
    @@all << self 
end 

def songs 
    @songs 
end

def add_song(song)
if @songs.include?(song) || song.artist != nil
    false
else
    song.artist = self 
    @songs << song
end
end

def genres
genre_array = []
Song.all.each do |a| 
    if a.artist == self 
     genre_array << a.genre
    end
end
genre_array.uniq
end


end