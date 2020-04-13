require 'pry'
class Song
    
    @@all = []

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def self.find_by_name(name)
        all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(filename)
        # modifies filename into usable strings
        new_filename = filename.split(/ - |.mp3/)
        artist_name = new_filename[0].strip
        song_name = new_filename[1].strip
        genre_name = new_filename[2].strip 
        
        # creates new objects using filename strings
        new_artist = Artist.find_or_create_by_name(artist_name)
        new_song = create(song_name)
        new_genre = Genre.find_or_create_by_name(genre_name)

        # assignes newly created objects to song objects
        new_song.artist = new_artist
        new_song.genre = new_genre
        
        # returns object
        new_song
      end    

      def self.create_from_filename(filename)
          new_from_filename(filename)
      end

    attr_accessor :name
    attr_reader :artist, :genre

    def initialize(name, artist = nil, genre = nil)
        @name = name
        @artist = artist
        @genre = genre
        self.artist = artist if artist != nil
        self.genre = genre if genre != nil
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
        if !genre.songs.include?(self)
            genre.songs << self 
        end
    end
end