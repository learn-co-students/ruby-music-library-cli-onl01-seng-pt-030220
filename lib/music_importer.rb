require 'pry'
class MusicImporter

  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def files
    Dir.children(path)
    # Dir.chdir(path){ |path| Dir.glob("*.mp3") }
  end

  def import
    files.each{ |song| Song.create_from_filename(song) }
  end

end

