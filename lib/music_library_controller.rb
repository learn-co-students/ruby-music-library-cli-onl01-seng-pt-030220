require 'pry'

class MusicLibraryController 

    def initialize(path="./db/mp3s")
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
        input = ""
        while input != "exit"
            input = gets
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
        Song.all.sort_by{|song| song.name}.each_with_index do |song, index|
            puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end 

    def list_artists
        Artist.all.sort_by{|artist| artist.name}.each_with_index do |artist, index| 
            puts "#{index+1}. #{artist.name}"
        end 
    end 

    def list_genres 
        Genre.all.sort_by{|genre| genre.name}.each_with_index do |genre, index|
            puts "#{index+1}. #{genre.name}"
        end 
    end 

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets
        current_artist = Artist.all.find{|artist| artist.name == input}
        Song.all.select{|song| song.artist == current_artist}.sort_by{|song| song.name}.each_with_index do |song, index|
            puts "#{index+1}. #{song.name} - #{song.genre.name}"
        end
    end 

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets
        current_genre= Genre.all.find{|genre| genre.name == input}
        Song.all.select{|song| song.genre == current_genre}.sort_by{|song| song.name}.each_with_index do |song, index|
            puts "#{index+1}. #{song.artist.name} - #{song.name}"
        end
    end 

    def play_song
        puts "Which song number would you like to play?"
        input = gets
        if input.to_i.between?(1, Song.all.length)
            songs = Song.all.sort_by{|song| song.name}
            puts "Playing #{songs[input.to_i-1].name} by #{songs[input.to_i-1].artist.name}"
        end 
    end
        
end