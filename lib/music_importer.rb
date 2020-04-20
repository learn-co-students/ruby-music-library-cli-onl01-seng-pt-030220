class MusicImporter

  attr_accessor :path

  def initialize(filepath)
    @path = filepath
  end

  def files
    Dir.entries(@path).select! {|filename| filename.end_with?(".mp3")}
  end

  def import
    files.each{ |song| Song.create_from_filename(song) }
  end
end
