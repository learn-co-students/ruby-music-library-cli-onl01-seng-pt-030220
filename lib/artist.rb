require_relative "../concerns/findable.rb"

class Artist

     attr_accessor :name  # getter and setter
     attr_reader :songs

     extend Concerns::Findable
     @@all=[]

     #extend Concerns::Findable::ClassMethods
     #include Concerns::Findable::InstanceMethods

     def initialize(name)   #instance method when you make your instance object ,also called  constructor
        @name = name
        #save
       @songs = []
     end

     def save           # instance method to save instance of object(artist) in the artist collection
        self.class.all << self
     end

     def self.all  #class method to return @@all that have all instance of artists ,getter or reader
       @@all
     end

     def add_song(song)  #instance method to add songs to the artist songs collection if its not already in artist songs collection.
        @songs << song   unless songs.include?(song)  #unless or if both work
        song.artist = self  if song.artist == nil   #if current artist not have in songs artist attribute then assign artist to current song artist attribute ,
     end

     def self.destroy_all  #class method destroy or clear all @@all
        all.clear
     end

     def self.create(name)   #custom constructor to build new instance of atrist depends on argument(artist name they send us),then save this new instance in our artist collection
        name1  = new(name)
        name1.save
        name1
     end

     def genres  # a collection of genres for all of the artist's songs (artist has many genres through songs)
         songs.collect do |song|
           song.genre
        end.uniq
     end


end
