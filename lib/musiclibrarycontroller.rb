require "pry"
class MusicLibraryController

attr_reader:path

    def initialize(path = './db/mp3s')
        @path = path
        new_importer = MusicImporter.new(path)
        new_importer.import
    end

    def cli_commands(input)
        if input == "list songs"
            list_songs
        elsif input == "list artists" 
            list_artists 
        elsif input == "list genres" 
            list_genres
        elsif input == "list artist"
            list_songs_by_artist
        elsif input == "list genre"
            list_songs_by_genre

        elsif input == "play song" 
            play_song
        
        end 
        end 

    def call(user_input = gets.chomp)
            user_input == " "
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            cli_commands(user_input)
            if user_input != "exit"
                call
            end
    end

    def list_songs
    sorted_songs = Song.all.sort{|a,b| a.name <=> b.name}
    sorted_songs.each_with_index do |a,b| 
    puts "#{b+1}. #{a.artist.name} - #{a.name} - #{a.genre.name}"  
    end
    
    end 

    def list_artists
    sorted_artists = Artist.all.sort{|a,b| a.name <=> b.name}
    sorted_artists.each_with_index do |a,b|
        puts "#{b+1}. #{a.name}"
    
    end 
    end

    def list_genres
    sorted_genres = Genre.all.sort{|a,b| a.name <=> b.name}
    sorted_genres.each_with_index do |a,b|
        puts "#{b+1}. #{a.name}"
    end
    end

    
    def list_songs_by_artist(user_input = gets.chomp)
    puts "Please enter the name of an artist:"
    if Artist.find_by_name(user_input) 
    #checks to see if the artist name actually exists
    sorted_songs_by_artist = Song.all.select{|a|a.artist.name == user_input}
    sorted_songs = sorted_songs_by_artist.sort{|a,b|a.name <=> b.name}
    sorted_songs.each_with_index do |a,b|
    puts "#{b+1}. #{a.name} - #{a.genre.name}"
    end
    end
    end
     
    def list_songs_by_genre(user_input = gets.chomp)
    puts "Please enter the name of a genre:"
    if Genre.find_by_name(user_input)
        selected_songs_by_genre = Song.all.select{|a|a.genre.name == user_input}
        sorted_songs = selected_songs_by_genre.sort{|a,b| a.name <=> b.name}
        sorted_songs.each_with_index do |a,b| 
        puts "#{b+1}. #{a.artist.name} - #{a.name}"
    end
    end
    end

    def play_song(user_input = gets.chomp)
        puts "Which song number would you like to play?"
        if user_input.to_i <= Song.all.count && user_input.to_i >=1
            user_input = (user_input.to_i) - 1
            sorted_songs = Song.all.sort{|a,b| a.name <=> b.name}
            puts "Playing #{sorted_songs[user_input].name} by #{sorted_songs[user_input].artist.name}" 
    
        end
    end



end
