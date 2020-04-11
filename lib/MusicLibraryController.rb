class MusicLibraryController
    
    def initialize(path = './db/mp3s')
        @path = path
        music = MusicImporter.new(path)
        music.import
    end

    def call

        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        input = ""
        while input != "exit"
            input = gets.strip
            case input 
                when "list songs"
                    list_songs
                    call
                when "list artists"
                    list_artists
                    call
                when "list genres"
                    list_genres
                    call
                when "list artist"
                    list_songs_by_artist
                    call
                when "list genre"   
                    list_songs_by_genre
                    call
                when "play song"
                    play_song
                    call
                when "exit"
                    return
            end
        end
    end
    
    def list_songs 
        Song.all.sort_by{|song| song.name}.each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end 

    def list_artists 
        Artist.all.sort_by{|artist| artist.name}.each.with_index(1) do |artist, index|
            puts "#{index}. #{artist.name}"
        end
    end 

    def list_genres 
        Genre.all.sort_by{|genre| genre.name}.each.with_index(1) do |genre, index|
            puts "#{index}. #{genre.name}"
        end
    end 

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets.strip
        current_artist = Artist.all.find {|artist| artist.name == user_input}
        Song.all.select{|song| song.artist == current_artist}.sort_by{|song| song.name}.each.with_index(1) do |song, index|
            puts "#{index}. #{song.name} - #{song.genre.name}"
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.strip
        current_genre = Genre.all.find {|genre| genre.name == user_input}
        Song.all.select{|song| song.genre == current_genre}.sort_by{|song| song.name}.each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name}"
        end
    end

    def play_song
        arr=[]
        Song.all.sort { |a,b| a.name <=> b.name }.uniq.each do |music|
           arr  <<  "Playing #{music.name} by #{music.artist.name}"
        end
        puts("Which song number would you like to play?")
        user_input = gets.strip.to_i
    #    user_input.between?(0, arr.length+1)
            if user_input > 0 && user_input <= arr.length
               puts arr[user_input-1]
            end
    end
end


