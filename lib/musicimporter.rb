require "pry"

class MusicImporter
  attr_accessor :path

  def initialize(path) # accepts a file path to a directory of MP3 files.
    @path = path # not "./db/mp3s/"
  end
  # => #<MusicImporter:0x00000000026b0240 @path="./db/mp3s/">

  def files # returns all of the imported filenames.
    Dir.entries(@path).select {|file| file.end_with?(".mp3")}
    # Dir.glab("#{path}"/*).map{|file| file.gsub("#{path}/", "")}
    # binding.pry
    # => ["The Field - Then It's White - rock.mp3", "ASAP Rocky - Peso - dance.mp3", "Frank Ocean - Novacane - dance.mp3", "Drake - Headlines - folk.mp3", "Action Bronson - Larry Csonka - indie.mp3",
    # "Purity Ring - Ungirthed - rap.mp3", "Fever Ray - The Wolf - electro.mp3", "Kurt Vile - Jesus Fever - rock.mp3", ...]
  end

  def import
    # imports all of the files from the library, instantiating a new Song object for each file.
    files.each {|filename| Song.create_from_filename(filename)}
    # binding.pry
  end
end
