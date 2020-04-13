require 'pry'

class MusicLibraryController

    attr_accessor :path

    def initialize(path='./db/mp3s')
        importer = MusicImporter.new(path)
        importer.import
        #@path = path
        #MusicImporter.new(path).import 
    end
 
    def call
        input = ''
    
        while input != 'exit'
          puts "Welcome to your music library!"
          puts "To list all of your songs, enter 'list songs'."
          puts "To list all of the artists in your library, enter 'list artists'."
          puts "To list all of the genres in your library, enter 'list genres'."
          puts "To list all of the songs by a particular artist, enter 'list artist'."
          puts "To list all of the songs of a particular genre, enter 'list genre'."
          puts "To play a song, enter 'play song'."
          puts "To quit, type 'exit'."
          puts "What would you like to do?"
          input = gets.chomp
    
          case input
          when 'list songs'
            self.list_songs
          when 'list artists'
            self.list_artists
          when 'list genres'
            self.list_genres
          when 'list artists'
            self.list_artists
          when 'list artist'
            self.list_songs_by_artist
          when 'list genre'
            self.list_songs_by_genre
          when 'play song'
            self.play_song
          else
            "Type in a valid request please"
          end

        end
    
    end

    def list_songs 
        Song.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end 

    
    #def list_artists
    #    Artist.all.sort {|a,b| a.name <=> b.name}.each_with_index do |artist, index|
    #       puts "#{index + 1}. #{artist.name}"
    #       #binding.pry
    #    end
    #end

    def list_artists
      artists = Artist.all.sort {|a,b| a.name <=> b.name}
      artists.each_with_index {|artist, i| puts "#{i+1}. #{artist.name}"}
      #binding.pry
    end
   
    
    def list_genres
        genres = Genre.all.sort {|a,b| a.name <=> b.name}
        genres.each_with_index {|genre, i| puts "#{i+1}. #{genre.name}"}
    end
    
    def list_songs_by_artist
      puts "Please enter the name of an artist:" #here the user will put in an artist's name
      input = gets.strip                         # this takes the user's input and removes any whitespace from the string
  
      if artist = Artist.find_by_name(input)

       artist.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, i|
          puts "#{i+1}. #{song.name} - #{song.genre.name}"
        end
      end
    end

    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.strip
  
      if genre = Genre.find_by_name(input)
        genre.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, i|
          puts "#{i+1}. #{song.artist.name} - #{song.name}"
        end
      end
    end

    def play_song 
      puts "Which song number would you like to play?"
      input = gets.strip.to_i 
      if  input > 0 && input <= Song.all.length 
        sorted_songs = Song.all.sort{|a,b| a.name <=> b.name}
        selected_song = sorted_songs[input-1]
        puts "Playing #{selected_song.name} by #{selected_song.artist.name}"
      end 
    end 

end 


