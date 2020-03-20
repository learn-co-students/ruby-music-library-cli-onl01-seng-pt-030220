class Song
    extend Concerns::Findable

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    def save
        @@all << self
    end

    def self.create(name)
        song = Song.new(name).tap do |song|
            song.save
        end
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.new_from_filename(filename)
        fn = filename.split(" - ")
        artist_name, song_name, genre_name = fn[0], fn[1], fn[2].gsub(".mp3", "")

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).tap {|s| s.save}
    end
end