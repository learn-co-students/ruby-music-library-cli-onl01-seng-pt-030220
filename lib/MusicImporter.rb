class MusicImporter

    def initialize(path)
        @path = path
    end

    def path
        @path
    end

    def files
        Dir.glob("mp3s").collect {|file| file.path}
    end


end