
module Persistable
  
  module ClassMethod
    def destroy_all
      self.all.clear
    end 

    def create(name)
      new_object = self.new(name)
      new_object.save
      return new_object
    end 
  end

  module InstanceMethod
    def save
      self.class.all << self
    end
  end 

end