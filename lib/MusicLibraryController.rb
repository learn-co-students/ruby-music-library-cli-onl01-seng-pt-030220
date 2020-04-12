class MusicLibraryController
    attr_accessor :path

    def initialize(path= "./db/mp3s")
        @path = path
        MusicImporter.new(path).import
    end

    def call
        input = nil
        while input != "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
        
        input = gets.strip
        cli_commands(input)
        end
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

    def list_songs
        Song.all.sort{|a, b| a.name <=> b.name}.uniq.each.with_index do |song, ind|
            puts "#{ind+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        Artist.all.sort{|a, b| a.name <=> b.name}.each_with_index do |artist, ind|
            puts "#{ind+1}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all.sort{|a, b| a.name <=> b.name}.each_with_index do |genre, ind|
            puts "#{ind+1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip

        if artist = Artist.find_by_name(input)
            artist.songs.sort{|a, b| a.name <=> b.name}.uniq.each.with_index do |song, ind|
                puts "#{ind+1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip

        if genre = Genre.find_by_name(input)
            genre.songs.sort{|a, b| a.name <=> b.name}.uniq.each.with_index do |song, ind|
                puts "#{ind+1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song(user_input = gets.chomp)
        puts "Which song number would you like to play?"
       input = gets.strip
    end
end