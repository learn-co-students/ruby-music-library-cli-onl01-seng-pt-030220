class Artist

   attr_accessor :name, :song, :genre, :musicImporter, :musicLibraryController
   @@all = []
   extend Concerns::Findable

   def initialize(name, song=nil, genre=nil)
    @name = name
    self.song=(song) if song != nil
    self.genre=(genre) if genre != nil
    @songs = []
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

   def self.create(artist)
    artist = self.new(artist)
    artist.save
    artist
   end

   def add_song(song)
      if song.artist == nil
         song.artist = self
      end
      if !@songs.include?(song)
         @songs << song
      end
   end

   def genres 
      songs.collect {|song| song.genre}.uniq
   end
end