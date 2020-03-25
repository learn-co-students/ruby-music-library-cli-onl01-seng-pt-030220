class MusicLibraryController
  attr_accessor :path
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

    input = gets.chomp
    while input != "exit"
      case input

      when "list artists"
        self.list_artists
      when "list songs"
        self.list_songs
      when "list genres"
        self.list_genres
      when "list artist"
        self.list_songs_by_artist
      when "list genre"
        self.list_songs_by_genre
      when "play song"
        self.play_song
      end
      input = gets.chomp
    end
  end

  def list_songs
    songs = Song.all.sort {|a,b| a.name <=> b.name}
    songs.each_with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort{|a, b| a.name <=> b.name}.each_with_index do |a, i|
      puts "#{i+1}. #{a.name}"
    end
  end

  def list_genres
    Genre.all.sort{|a, b| a.name <=> b.name}.each_with_index do |a, i|
      puts "#{i+1}. #{a.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if Artist.find_by_name(input)
      artist = Artist.find_by_name(input)
        artist.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|
       puts "#{i+1}. #{s.name} - #{s.genre.name}"
     end
   end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if Genre.find_by_name(input)
      genre = Genre.find_by_name(input)
        genre.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|
       puts "#{i+1}. #{s.artist.name} - #{s.name}"
     end
   end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip

    songs = Song.all.sort {|a,b| a.name <=> b.name}
    songs.each_with_index do |song, i|
      if i == input.to_i-1
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end
  end

end
