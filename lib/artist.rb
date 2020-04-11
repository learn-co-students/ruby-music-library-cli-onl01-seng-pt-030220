class Artist
    extend Concerns::Findable


    @@all = []
    
    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

attr_accessor :name
attr_reader :songs

def initialize(name)
    @name = name
    @songs = []
end

def genres
    songs.collect{|s| s.genre}.uniq
end


def self.create(name)
    song = new(name)
    song.save
    song
end

#rspec spec/005_songs_and_genres_spec.rb


def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end

def save
    @@all << self
end

end