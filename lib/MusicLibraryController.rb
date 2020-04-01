class MusicLibraryController

    attr_accessor :musicimporter

    def initialize(path = './db/mp3s')
        @path = path
        MusicImporter.new(path).import
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
    
        input = gets

        return list_songs if input == "list songs"
        return list_artists if input == "list artists"
        return list_genres if input == "list genres"
        return list_songs_by_artist if input == "list artist"
        return list_songs_by_genre if input == "list genre"
        return play_song if input == "play song"

        return call until input == "exit"
    end

    def list_songs
        song_list = Song.all.sort_by {|song| song.name}.uniq
        song_list.each_with_index do |song, i|
            puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        artist_list = Artist.all.sort_by {|artist| artist.name}.uniq
        artist_list.each_with_index do |artist, i|
            puts "#{i + 1}. #{artist.name}"
        end
    end

    def list_genres
        genre_list = Genre.all.sort_by {|genre| genre.name}.uniq
        genre_list.each_with_index do |genre, i|
            puts "#{i + 1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist_name = gets
        artist = Artist.find_by_name(artist_name)
        if artist 
            song_list = artist.songs.sort_by {|song| song.name}
            song_list.each_with_index do |song, i|
                puts "#{i + 1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre_name = gets
        genre = Genre.find_by_name(genre_name)
        if genre 
            song_list = genre.songs.sort_by {|song| song.name}
            song_list.each_with_index do |song, i|
                puts "#{i + 1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        song_number = gets.to_i
        song_list = Song.all.sort_by {|song| song.name}.uniq
        if (1..song_list.length).include?(song_number)
            song = song_list[song_number - 1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end

end