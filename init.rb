input_file = ARGV[0]

file = File.open(input_file)
water_units = file.first.strip.to_i

cave = []
file.each do |line|
  line.strip.split("").each_with_index do |element, i|
    cave[i]=cave[i] || []
    cave[i].push(element)
  end
end

class Water
  attr_accessor :x, :y
  def initialize(cave,x,y)
    @cave=cave
    @x=x
    @y=y
  end

  def left_is_open
    @cave[@x-1][@y]==" "
  end

  def bottom_is_open
    @cave[@x][@y+1]==" "
  end

  def right_is_open
    @cave[@x+1][@y]==" "
  end

  def space_below
    y = @y
    while(@cave[@x][y])
      return true if @cave[@x][y]==" "
      y=y+1
    end

    false
  end
      

  def move_down
    @y=@y+1
  end

  def move_right
    @x=@x+1
  end

  def move_up
    @y=@y-1
  end

  def move_left
    @x=@x-1
  end

  def is_in_open_spot
    @cave[@x][@y]!="~" and @cave[@x][@y]!="#"
  end
end

water_units = 4

water_units.times do
  water = Water.new(cave, 1, 1)

  while(!water.is_in_open_spot)
    puts water.x
    puts water.y
    if(water.left_is_open)
      puts "left open"
      water.move_left
    elsif(water.space_below)
      puts "bottom open"
      water.move_down
    elsif(water.right_is_open)
      puts "right open"
      water.move_right
    else
      puts "move up"
      water.move_up
    end 
  end
  
  cave[water.x][water.y] = "~"
end

cave[0].size.times do |index|
  cave.each do |array|
    print array[index]
  end
  print "\n"
end



