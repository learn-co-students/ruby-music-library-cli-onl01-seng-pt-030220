require 'pry'

class MusicImporter
    
    attr_accessor :path

    def initialize(path)
        @path = path

    end

    def files
        file_array = Dir.entries(self.path)
        # binding.pry
        file_array.select {|filename| filename.include?(".mp3")}
    end

    def import
        files.each do |filename|
            Song.create_from_filename(filename)
        end
    end

end