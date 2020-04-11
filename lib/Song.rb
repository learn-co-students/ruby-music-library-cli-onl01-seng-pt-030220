class Song

    attr_accessor :name, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        if artist != nil
            self.artist = artist
        end
        if genre != nil
            self.genre = genre
        end
        save
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
    def artist
        @artist
    end
    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre
        @genre
    end
    def genre=(genre)
        @genre = genre
        #genre.add_song(self)
        if !genre.songs.include?(self)
            genre.songs << self
        end
    end

    def self.find_by_name(name)
        all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(file)
        array = file.split(" - ")
        song_name = array[1]
        artist_name = array[0]
        genre_name = array[2].split(".mp3").join

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name, artist, genre)

    end

    def self.create_from_filename(file)
        @@all << self.new_from_filename(file)
    end
end