class MusicImporter


attr_reader :path,:import
def initialize(path)
  @path=path
end

def files
  filename= Dir.entries(@path)
  filename.select do |file|
      file.include?('mp3')
  end
end

def import
  files.each do |song|
    Song.create_from_filename(song)
  end

end

end
