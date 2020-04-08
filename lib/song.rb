require_relative "../concerns/findable.rb"
require "pry"

class Song

  attr_accessor :name
  attr_reader :genre,:artist

  extend Concerns::Findable

    @@all = []

  def initialize(name,artist=nil,genre=nil)
     @name = name
     self.artist=artist if artist
     self.genre=genre   if genre
  end

  def artist=(artist)
    @artist=artist
    artist.add_song(self)
  end

   def genre=(genre)
     @genre=genre
     genre.songs << self unless genre.songs.include?self
   end

  def save
     self.class.all << self  #self here new instance of class , #everytime when  create new instance  of class  we save new instance of class  inside @@all
    # or Song.all << self
    # or  @@all << self
  end

  def self.all
    @@all
  end
  def self.destroy_all
       all.clear
  end

  def self.create(song)
    song1= self.new(song)
    song1.save      #We have to save it at @@all because when we make new song its inside self.create ,not go back to save
    song1
  end

  #  def self.find_by_name(song_name)
    #  @@all.detect do |song|
    #    song.name == song_name
    #  end
  #  end

  #  def self.find_or_create_by_name(song_name)
  #      if self.find_by_name(song_name)
  #         self.find_by_name(song_name)
  #      else
  #        self.create(song_name)
  #      end
  #  end
     def artist_name=(artistname)
        self.artist = Artist.find_or_create_by_name(artistname)
        self.artist.add_song(self)
     end

     def genre_name=(genrename)
       self.genre = Genre.find_or_create_by_name(genrename)
    end

    def self.new_from_filename(file)
       file = file.split(' - ')
       song = file[1]
       artist = file[0]
       genre =file[2].split('.')[0]
       # binding.pry
       song_ins = find_or_create_by_name(song)
       song_ins.artist_name = artist
       song_ins.genre_name = genre
       song_ins
    end

    def self.create_from_filename(filename)
        @@all << new_from_filename(filename)
    end

end
