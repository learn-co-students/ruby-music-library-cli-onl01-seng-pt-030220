module Concerns::Findable

  def find_by_name(name)
    self.all.find{|klass| klass.name == name}
  end

  def find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end
end

# find_by_name should be defined here
# find_or_create_by_name should be defined here
