class Genre

    @@all = []

    def self.all 
        @@all
    end 

    def self.destroy_all
        @@all.clear
    end 

    def self.create(genre)
        genre = self.new(genre)
        genre.save
        genre
    end 

    attr_accessor :name

    attr_reader :songs

    extend Concerns::Findable

    def initialize(name)
        @name = name
        #@@all << self
        @songs = []
    end

    def save
        @@all << self 
    end

    def songs 
        @songs 
    end 

    def artists
        artists =  self.songs.collect do |song|
           song.artist
        end
         artists.uniq
    end



end 