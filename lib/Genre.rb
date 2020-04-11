class Genre
    
    attr_accessor :name
    @@all = []
    extend Concerns::Findable
    def initialize(name, song=nil)
        @name = name
        @songs = []
        if song != nil
            self.song = song
        end
        save
    end
    
    def songs
        @songs
    end
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
        self.new(name)
    end

    def artists
        songs.collect {|song| song.artist}.uniq
    end

end