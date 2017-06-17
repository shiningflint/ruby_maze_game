class Player
  DIRECTION = ["north", "east", "south", "west"]
  attr_accessor :in_room

  def initialize direction, in_room
    @direction = direction
    @in_room = in_room
    @door_ahead = false
  end

  def direction
    @direction
  end

  def direction= direction
    @direction = direction
  end

  def show_direction
    DIRECTION[@direction]
  end

  def move action
    if action == "right" || action == "left" || action == "forward" || action == "turn back"
      @direction = check_door @direction, @in_room, action
    else
      puts "INPUT THE RIGHT ONE PLEASE"
    end
  end

  def recon
    @in_room.doors.each_with_index do |door, index|
      compare_direction @direction, door, index
    end
  end

  private
    def compare_direction direction, door, index
      difference = direction - index
      if door != nil
        exist = "a door"
      else
        exist = "no door"
      end

      if difference == 0
        puts "There is #{exist} in front of you"
      elsif difference == 1
        puts "There is #{exist} on your left"
      elsif difference == 2
        puts "There is #{exist} on your back"
      elsif difference == 3 || difference == -1
        puts "There is #{exist} on your right"
      else
        puts "not yet implemented"
      end
    end

    def check_door direction, in_room, action
      direction = turn_direction action, direction
      if in_room.doors[direction] != nil
        puts "There is a door in front of you"
      else
        puts "There is no door"
      end
      return direction
    end

    def turn_direction action, direction
      if action == "forward"
        return direction
      elsif action == "right"
        return turn_right direction
      elsif action == "left"
        return turn_left direction
      elsif action == "turn back"
        return turn_back direction
      else
        return "INVALID INPUT"
      end
    end

    def turn_right player
      if player == 3
        return player = 0
      else
        return player += 1
      end
    end

    def turn_left player
      if player == 0
        return player = 3
      else
        return player -= 1
      end
    end

    def turn_back player
      if player >= 2
        return player -= 2
      elsif player == 1
        return player = 3
      elsif player == 0
        return player = 2
      else
        return puts "STRANGEE!!!"
      end
    end
end

class MazeRoom
  attr_reader :room_number, :doors
  def initialize room_number, doors
    @room_number = room_number
    @doors = doors
  end

end

rooms = {
  1 => MazeRoom.new(1, ["goal", nil, 2, nil]),
  2 => MazeRoom.new(2, [1, nil, nil, nil])
}
player1 = Player.new 0, rooms[2]
puts player1.in_room

while true
  puts "\n\nPlayer is heading #{player1.show_direction}"
  puts "Player is in room #{player1.in_room.room_number}"
  player1.recon
  puts "Move player 1 (right, left, forward, turn back)"
  action = $stdin.gets.chomp
  player1.move action
end
