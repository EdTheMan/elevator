class Person
attr_accessor :intended_floor

	def initialize(floor=1)
		@intended_floor = floor
	end

	def call_elevator(elevator)
		elevator.call(@intended_floor)
	end

	def get_intended_floor 
		return @intended_floor
	end
end