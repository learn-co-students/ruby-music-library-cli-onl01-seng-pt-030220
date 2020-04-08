class MusicImporter

 def initialize(path)
  @path = path
 end

 def path
  Dir.glob(@path).join
 end

 def files
  Dir.children("#{path}")
 end

 def import
  files.each {|file| Song.create_from_filename(file) }
 end

end 