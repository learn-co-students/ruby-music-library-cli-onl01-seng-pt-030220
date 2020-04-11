require 'pry'

class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        # files_array = Dir.entries(@path)
        # files_array.select {|file| file.include?(".mp3")}
        Dir.entries(@path).select {|file| file.include?(".mp3")}
       #binding.pry
    end

    def import
        files.each do |filename|
            Song.create_from_filename(filename)
        end
    end
    
    #binding.pry
end