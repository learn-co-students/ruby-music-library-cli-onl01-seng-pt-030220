class Song
    attr_accessor :name
    @@all = []
    extend Concerns::Findable

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist) if artist != nil
        self.genre=(genre) if genre != nil
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
        new_song = Song.new(name)
        new_song.save
        new_song
    end

    def artist
        @artist
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self if genre.songs.include?(self) != true
    end

    def genre
        @genre
    end

    def self.find_by_name(song)
        @@all.detect do |songs|
            songs.name == song
        end
    end

    def self.find_or_create_by_name(song)
        if self.find_by_name(song) == nil
            self.create(song)
        else self.find_by_name(song)
        end
    end

    def self.new_from_filename(filename)
        array_filename = filename.split(" - ")
        my_song = array_filename[1]
        my_artist = array_filename[0]
        my_genre = array_filename[2].gsub(".mp3",'')
        #binding.pry
        new_artist_from_filename = Artist.find_or_create_by_name(my_artist)
        new_genre_from_filename = Genre.find_or_create_by_name(my_genre)
        new_song_from_filename = Song.new(my_song,new_artist_from_filename,new_genre_from_filename) if find_by_name(my_song) == nil
    end

    def self.create_from_filename(filename)
        #new_from_filename(filename).save
        new_from_filename(filename).tap {|item| item.save}
        
        
        #binding.pry
        #created_song.genre = filename.split(" - ")[2].gsub(".mp3",'')
      
    end

    def to_s
        self.name
    end

end