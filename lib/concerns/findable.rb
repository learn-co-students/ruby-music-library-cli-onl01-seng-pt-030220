module Concerns::Findable

    def find_by_name(name)
        all.find {|object| object.name == name}
    end

    def find_or_create_by_name(name)
        found_object = find_by_name(name)
        return found_object ? found_object : self.create(name)
    end

end