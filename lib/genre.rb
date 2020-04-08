require_relative "../concerns/findable.rb"

class Genre
   attr_accessor :name
   attr_reader :songs

   extend Concerns::Findable

   @@all = []
   #extend Concerns::Findable::ClassMethods
   #include Concerns::Findable::InstanceMethods


   def initialize(name)
     @name=name
     #save
     @songs =[]
   end

   def  save
    self.class.all << self
   end

   def self.all   #we put this method in module
       @@all
   end

   def self.destroy_all
       all.clear
   end

   def self.create(name)
     name1 =new(name)
     name1.save
     name1
   end

   def artists
      songs.collect{ |song|
        song.artist
      }.uniq
   end

end
