module Concerns::Findable

    #note - extend is for class methods, include is for instance methods. So self on extend will be the class. self on include will be the instance.


    def find_by_name(name)
        all.detect do |i|
            i.name == name
        end
    end

    def find_or_create_by_name(name)
        if find_by_name(name) == nil
            create(name)
        else find_by_name(name)
        end
    end
end