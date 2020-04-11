 require 'pry'
 class MusicLibraryController

    attr_accessor :path

    def initialize(path="./db/mp3s")
        @path = path
        my_importer = MusicImporter.new(@path)
        my_importer.import
    end

    def call
        user_input = ''
        while user_input != 'exit'
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"

            user_input = gets.chomp 
        
            case user_input
                when 'list songs'
                    list_songs
                when 'list artists'
                    list_artists
                when  'list genres'
                    list_genres
                when 'list artist'
                    list_songs_by_artist
                when 'list genre'
                    list_songs_by_genre
                when 'play song'
                    play_song
            end
        end
    end
    

    def list_songs
        my_songs = Song.all.sort { |song1, song2| song1.name <=> song2.name} 
        my_songs.each_with_index do |my_song, index|
            puts "#{index+1}. #{my_song.artist.name} - #{my_song} - #{my_song.genre.name}"
        end
    end
   
    def list_artists
        my_artists = Artist.all.sort { |artist1, artist2| artist1.name <=> artist2.name}
        my_artists.each_with_index do |my_artist, index|
            puts "#{index+1}. #{my_artist.name}"
        end
    end

    def list_genres
        my_genres = Genre.all.sort { |genre1, genre2| genre1.name <=> genre2.name}
        my_genres.each_with_index do |my_genre, index|
            puts "#{index+1}. #{my_genre.name}"
        end
    end
    
    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets.chomp

        my_songs = Song.all.sort { |song1, song2| song1.name <=> song2.name} 
        my_artist_songs = my_songs.select {|song| song.artist.name == user_input}

        my_artist_songs.each_with_index do |my_song, index|
             puts "#{index+1}. #{my_song} - #{my_song.genre.name}"
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.chomp

        my_songs = Song.all.sort { |song1, song2| song1.name <=> song2.name} 
        my_genre_songs = my_songs.select {|song| song.genre.name == user_input}

        my_genre_songs.each_with_index do |my_song, index|
             puts "#{index+1}. #{my_song.artist.name} - #{my_song}"
        end

    end

    def play_song
        puts "Which song number would you like to play?"
        #puts list_songs
        user_input = gets.chomp.to_i 
        my_songs = Song.all.sort { |song1, song2| song1.name <=> song2.name} 

        if user_input > 0 && user_input < Song.all.length+1
            selected_song = my_songs[user_input - 1]
            puts "Playing #{selected_song.name} by #{selected_song.artist.name}"
        end

        #binding.pry

    end
 end