class GroupGenerator
  attr_reader :groups

  def initialize(names, group_size)
    raise NoNamesGivenError if names.empty?

    @names = names.shuffle
    @group_size = group_size
    @groups = []
  end

  def group!(rest_names = @names)
    group = rest_names.shift(@group_size)
    @groups << group
    group! unless rest_names.empty?
  end

  class NoNamesGivenError < StandardError
  end
end
