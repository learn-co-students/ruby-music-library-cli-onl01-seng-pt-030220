require "pry"

class MusicLibraryController
  attr_accessor :path

  def initialize(path = "./db/mp3s")
    # binding.pry
    @path = path
    mlc = MusicImporter.new(path)
    mlc.import
  end

end
