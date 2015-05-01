class Floor
attr_accessor :people_queue
	
	FLOOR_MAX_PERSONS = 50

	def initialize(elevator,people=[])

		@elevator = elevator
		@number_of_elevators = 1
		@people_queue = Queue.new
		people.each do |person|
			@people_queue.push(person)
		end
	end

	def call(floor)
		@elevator.call(floor)
	end

	def add_person(person,elevator)
		people_queue << person
		person.call_elevator(elevator)
	end

	def to_s

		@floor_s = ""
		@floor_count.downto(1) {|i|
			if i == @current_floor
				@floor_s += "1\n"
			else 
				@floor_s += "0\n"
			end
		
		}

		@floor_s += "\n"

	end
end