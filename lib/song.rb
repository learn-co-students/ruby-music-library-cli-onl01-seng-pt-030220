class Song
    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name, artist=nil, genre=nil)
        new(name, artist, genre).save
        @@all.last
    end 

    def self.find_by_name(name)
        @@all.find {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        if self.find_by_name(name)
            self.find_by_name(name)
        else
            self.create(name)
        end
    end

    def self.new_from_filename(filename)
        arr = filename.split(" - ")

        song_name = arr[1]
        artist_name = arr[0]
        genre_name = arr[2].split(".mp3").join

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end
        
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end
    
    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end
end