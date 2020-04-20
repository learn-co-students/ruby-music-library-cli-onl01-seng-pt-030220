class MusicLibraryController
  attr_accessor :music_importer, :path

  def initialize(path = "./db/mp3s")
     MusicImporter.new(path).import
  end

  def call
    response = nil
    while response != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      response = gets.strip.downcase
      case response
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      else
        nil
      end
    end
  end

  def list_songs
    sorted_songs = Song.all.sort_by {|song| song.name}
    sorted_songs.uniq!.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artist_list = Artist.all.collect {|artist| artist.name}
    artist_list.sort.uniq.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist}"
    end
  end

  def list_genres
    genre_list = Song.all.collect {|song| song.genre.name}
    genre_list.sort.uniq!.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    response = gets.strip
    song_list = Song.all.sort_by {|song| song.name}
    artist_song_list = song_list.find_all {|song| song.artist.name == response}
    artist_song_list.uniq.each_with_index do |song, index|
      puts "#{index + 1}. #{song.name} - #{song.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    response = gets.strip
    song_list = Song.all.sort_by {|song| song.name}
    genre_song_list = song_list.find_all {|song| song.genre.name == response}
    genre_song_list.uniq.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name}"
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    response = gets.strip.to_i
    sorted_songs = (Song.all.sort_by {|song| song.name}).uniq!
    if response.between?(1, sorted_songs.count)
      index = response - 1
      puts "Playing #{sorted_songs[index].name} by #{sorted_songs[index].artist.name}"
    end
  end
end