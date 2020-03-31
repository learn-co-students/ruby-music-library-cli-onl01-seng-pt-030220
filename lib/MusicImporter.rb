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
    files.each do |file| 
      single_file = file 
    Song.create_from_filename(single_file)
    end
  end


end 