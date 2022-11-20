require_relative 'group_generator'

class Interface
  def initialize
    @names = []
  end

  def run!
    gap
    say_hello
    gap
    get_group_size
    gap
    get_names
    gap
    generate_groups
    gap
    puts 'Thanks for using the GroupGenerator!'
  end

  private

  def gap
    puts ''
    puts '=========='
    puts ''
  end

  def say_hello
    puts 'Hello, I am the group generator.'
    puts 'With me, you can generate groups from a list of names with any given group sizes!'
    puts "Let's go!"
  end

  def get_group_size
    @group_size = nil
    puts 'First, give me the size you want for each group, please:'
    print '>>> '
    @group_size = gets.chomp.to_i
    get_group_size unless positive?
  end

  def positive?
    if @group_size.positive?
      true
    else
      puts 'This is not a valid (positive) integer, please try again!'
      puts ''
      false
    end
  end

  def get_names
    puts 'Now, please write the names. When you are at the end, just press enter with out name provided'
    get_name
  end

  def get_name
    puts ''
    puts "Name #{@names.count + 1}:"
    print '>>> '
    name = gets.chomp

    if name.empty?
      check_ended
    else
      @names << name
      get_name
    end
  end

  def check_ended
    puts ''
    puts 'Are you done with your list? Please write yes/no'
    print '>>> '
    answer = gets.chomp

    if answer == 'no'
      get_name
    elsif answer != 'yes'
      check_ended
    end
  end

  def generate_groups
    generator = GroupGenerator.new(@names, @group_size)
    generator.group!

    puts 'Here are the groups:'
    puts ''
    generator.groups.each_with_index do |group, i|
      puts "Group #{i + 1}"
      group.each { |name| puts "--- #{name}"}
      puts ''
    end
  end
end

Interface.new.run!
