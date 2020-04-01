require_relative './concerns/findable.rb'

class Song

    extend Concerns::Findable

    @@all = []

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(song_name)
        new_song = Song.new(song_name)
        new_song.save
        new_song
    end

    def self.new_from_filename(filename)
        file_parts = filename.split(" - ")
        song_artist = file_parts[0]
        song_name = file_parts[1]
        song_genre = file_parts[2].chomp(".mp3")

        new_song = find_or_create_by_name(song_name)
        new_song.artist = Artist.find_or_create_by_name(song_artist)
        new_song.genre = Genre.find_or_create_by_name(song_genre)

        new_song
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end

    attr_accessor :name
    attr_reader :artist, :genre

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist=(artist) if artist
        self.genre=(genre) if genre
    end

    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist
        self.artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

end