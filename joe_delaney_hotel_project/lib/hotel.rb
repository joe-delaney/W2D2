require_relative "room"

class Hotel

    attr_reader :rooms

    def initialize(name, hash)
        @name = name
        @rooms = {}
        hash.each do |k, v|
            @rooms[k] = Room.new(v)
        end
    end

    def name 
        @name.split(" ").map(&:capitalize).join(" ")
    end

    def room_exists?(name)
        return true if @rooms.has_key?(name)
        return false
    end

    def check_in(person, room_name)
        if room_exists?(room_name)
            if @rooms[room_name].add_occupant(person)
                p "check in successful" 
            else
                p 'sorry, room is full'
            end
        else
            p 'sorry, room does not exist'
        end
    end

    def has_vacancy?
        @rooms.each {|room_name, room| return true if !room.full?}
        return false 
    end

    def list_rooms
        @rooms.each { |room_name, room| puts room_name + " : " + room.available_space.to_s }
    end

end
