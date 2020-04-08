class MusicLibraryController

  attr_accessor :music_im

    def initialize(path='./db/mp3s')
      @music_im = MusicImporter.new(path)
      @music_im.import

    end

    def call

        puts("Welcome to your music library!")
        puts("To list all of your songs, enter 'list songs'.")
        puts("To list all of the artists in your library, enter 'list artists'.")
        puts("To list all of the genres in your library, enter 'list genres'.")
        puts("To list all of the songs by a particular artist, enter 'list artist'.")
        puts("To list all of the songs of a particular genre, enter 'list genre'.")
        puts("To play a song, enter 'play song'.")
        puts("To quit, type 'exit'.")
        puts("What would you like to do?")
        user_input = gets.chomp
        case user_input
         when 'list songs'
           list_songs
         when 'list artists'
           list_artists
         when 'list genres'
           list_genres
         when 'list artist'
           list_songs_by_artist
         when 'list genre'
           list_songs_by_genre
         when 'play song'
           play_song
         end
        user_input = gets.chomp until user_input ==  "exit"

    end


    def list_songs
      Song.all.sort { |a,b| a.name <=> b.name }.uniq.each.with_index{ |music,i|
            puts "#{i+1}. #{music.artist.name} - #{music.name} - #{music.genre.name}"
       }
    end

     def list_artists

       Artist.all.sort { |a,b| a.name <=> b.name }.uniq.each.with_index{ |music,i|
             puts "#{i+1}. #{music.name}"
        }
     end
        #music_im.import.sort { |a,b| a <=> b }.collect do |music|
        #  music.split(' - ')[0]
      #  end.uniq.each.with_index  do |music,i|
          #puts "#{i+1}. #{music.}"
        #end


     def list_genres
       Genre.all.sort { |a,b| a.name <=> b.name }.uniq.each.with_index{ |music,i|
             puts "#{i+1}. #{music.name}" }

     end

     def list_songs_by_artist

        puts("Please enter the name of an artist:")
        user_input= gets.chomp
        artist = Artist.find_by_name(user_input)

          if artist != nil
            artist.songs.sort { |a,b| a.name <=> b.name }.uniq.each.with_index{ |music,i|
                  puts   "#{i+1}. #{music.name} - #{music.genre.name}"
               }
          end

      #binding.pry
     end

     def list_songs_by_genre
       puts("Please enter the name of a genre:")
       user_input= gets.chomp
       genre = Genre.find_by_name(user_input)
         if genre != nil
           genre.songs.sort { |a,b| a.name <=> b.name }.uniq.each.with_index{ |music,i|
                 puts   "#{i+1}. #{music.artist.name} - #{music.name}"
              }
         end
     end

     def play_song
       arr=[]
       Song.all.sort { |a,b| a.name <=> b.name }.uniq.each do |music|
          arr  <<  "Playing #{music.name} by #{music.artist.name}"
       end
       puts("Which song number would you like to play?")
          user_input = gets.strip.to_i
      #  if  user_input.between?(0, arr.length+1)
        if user_input > 0 && user_input <= arr.length
              puts arr[user_input-1]
         end

       end


end
