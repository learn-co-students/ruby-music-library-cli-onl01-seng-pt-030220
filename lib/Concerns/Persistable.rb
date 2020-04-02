
module Persistable
  
  module ClassMethod
    
    def destroy_all
      self.all.clear
    end 

  end

  module InstanceMethod
    
    def save
      self.class.all << self
    end

  end 

end