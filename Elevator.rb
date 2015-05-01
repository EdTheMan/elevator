class Elevator
attr_accessor :state
attr_accessor :passengers
attr_accessor :current_floor
attr_accessor :calls

ELEV_MAX_PERSONS = 10

	def initialize(options = {})
		#@state = 1 means moving up, 0 means moving down
		@calls = 0
		@passengers = []
		@current_floor = options[:current_floor] || default_current_floor
		@top_floor = options[:top_floor] || default_current_floor
		@state = options[:state] || default_state
		@floor_count = options[:floor_count] || default_floor_count
	end

	def default_current_floor
		1
	end

	def default_state
		1
	end

	def default_floor_count
		1
	end

	def direct(floor)
		if @current_floor == floor
			#open door
		elsif @current_floor < floor
			@state = 1
		else
			@state = 0
		end		
	end

	def call(floor)
		@calls += 1
	end

	def get_calls
		return @calls
	end

	def decrement_calls
		@calls -=1
	end

	def move
		if(@calls == 0) && (@passengers.length == 0)
			@state = 0
			if @current_floor > 1
				@current_floor -=1
			end
		elsif @state == 1 && @current_floor < @top_floor
			@current_floor += 1
		elsif @state == 1 && @current_floor == @top_floor
			@state = 0
			@current_floor -= 1
		elsif @state == 0 && @current_floor > 1
			@current_floor -= 1
		elsif @state == 0 && @current_floor == 1
			@state = 1
			@current_floor += 1
		else
			p @state
			p @current_floor
			p "Error"
		end
	end

	def add_passenger(person)
		@passengers << person
	end

	def check_passengers
		@passengers.each do |person|
			if person.intended_floor == @current_floor
				exit(person)
				print "Person exited at floor ", @current_floor, "\n"
			end
		end
	end

	def exit(person)
		@passengers.delete_at(@passengers.index(person))
	end

	def to_s
		@elevator_s = ""
		@floor_count.downto(1) {|i|
			if i == @current_floor
				@elevator_s += "|1|\n"
			else 
				@elevator_s += "|0|\n"
			end
		
		}
		@elevator_s += "Elevator has " + @passengers.length.to_s + " people\n"
		@elevator_s
	end
end