class Building
attr_accessor :floors

	@number_of_elevators = 0
	@number_of_floors = 0

	def initialize(options = {})
		@elevator = options[:elevator]
		@floors = options[:floors]
		@number_of_elevators = 1
		@number_of_floors = @floors.length
	end

	def run

		@elevator.move
		@elevator.check_passengers

		@floor_people = @floors[@elevator.current_floor-1].people_queue

		while !@floor_people.empty?
			@person = @floor_people.pop
			@elevator.add_passenger(@person)
			@elevator.decrement_calls
			@elevator.direct(@person.intended_floor)
		end

		
	end

end