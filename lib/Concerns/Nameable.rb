module Nameable

  module ClassMethod

    def create(name)
      new_object = self.new(name)
      new_object.save
      new_object
    end 

  end 
  
end