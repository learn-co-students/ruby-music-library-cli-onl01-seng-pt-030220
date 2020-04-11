require "pry"

class Song 
    extend Concerns::Findable
    @@all = [] 

    def self.all 
        @@all 
    end 
    
    def self.destroy_all 
        @@all.clear 
    end 

    def self.create(name)
        new_song = self.new(name)
        # binding.pry
    end



    def self.new_from_filename(filename)
    new_filename = filename.split(/ - |.mp3/)
    new_artist = new_filename[0].strip
    new_song_name = new_filename[1].strip
    new_genre = new_filename[2].strip
    #assigning the filename into variables.

    new_song = find_or_create_by_name(new_song_name)
    new_artist = Artist.find_or_create_by_name(new_artist)
    new_genre = Genre.find_or_create_by_name(new_genre)
    #creating new Genre & Artist classes with the info from the filename
    new_song.artist = new_artist 
    new_song.genre  = new_genre
    #assigning the attributes to the newly created Genre & Artist classes to the new_song
    new_song
    #returning new_song at the end
    end
    
    def self.create_from_filename(filename)
    new_from_filename(filename)
    end


    attr_accessor :name
    attr_reader :artist, :genre    

    def initialize(name, artist = nil, genre = nil)
        @name = name 
        self.artist = artist if artist 
        self.genre = genre if genre
        save
        
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
    if genre.songs.include?(self)
        false
    else
        genre.songs << self
    end
    end 



end