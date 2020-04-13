class Artist

    extend Concerns::Findable 

    attr_accessor :name, :songs  

    @@all = []

    def self.all
        @@all
    end 

    def self.destroy_all
        @@all.clear
    end 
    
    def save 
        @@all << self 
    end 

    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end 

    def initialize(name)
        @name = name 
        @songs = []
    end 

    def add_song(song)
        if song.artist == nil
          song.artist = self
        end 
        if @songs.include?(song)
            nil 
        else @songs << song
        end 
    end

    def genres
        array = []
        @songs.map do |song| 
          if array.include?(song.genre)
            nil 
          else
            array << song.genre 
          end
        end 
        array
    end
end 