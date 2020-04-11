require "pry"
class MusicImporter 

    attr_accessor :files, :path

    def initialize(path)
    @path = path
    end

    def files
        Dir.chdir(@path) do | path |
            Dir.glob("*.mp3")
        end
    end

    def import
    files.each do |a| 
        Song.create_from_filename(a)
    end

    end

end