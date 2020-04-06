

class MusicLibraryController
  
  attr_accessor :music_importer


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
    input = gets
    list_songs if input == "list songs" 
    list_artists if input == "list artists"
    list_genres if input == "list genres"
    list_songs_by_artist if input == "list artist"
    list_songs_by_genre if input == "list genre"
    play_song if input == "play song"

    return call until input == "exit" 
    
  end

  def list_songs
    sorted_songs = Song.all.sort_by { |song| song.name }.uniq

    sorted_songs.each_with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end 
  end


  def list_artists
    sorted_artist = Artist.all.sort_by { |artist| artist.name }

    sorted_artist.each_with_index do |artist, index|
      puts "#{index+1}. #{artist.name}" 
    end 
  end 

  def list_genres
    sorted_genre = Genre.all.sort_by { |genre| genre.name }

    sorted_genre.each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}" 
    end 
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets
    artist = Artist.find_by_name(artist_name)
    if artist 
      sorted_songs = artist.songs.sort_by { |song| song.name}

      sorted_songs.each_with_index do |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end 
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets
    genre = Genre.find_by_name(genre_name)
    if genre 
      sorted_songs = genre.songs.sort_by { |song| song.name}

      sorted_songs.each_with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
      end 
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_choice = gets.to_i
    sorted_songs = Song.all.sort_by { |song| song.name }.uniq
    if (1..sorted_songs.length).include?(song_choice)
      song = sorted_songs[song_choice - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end 

end 