class MusicImporter

    def initialize(path)
        @path = path
    end

    def path
        @path
    end

    def files
        Dir.chdir(@path) {|path| Dir.glob("*.mp3")}
    end

    def import
        self.files.each {|filename| Song.create_from_filename(filename)}
    end


end