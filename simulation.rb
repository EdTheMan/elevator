require './Person.rb'
require './Building.rb'
require './Floor.rb'
require './Elevator.rb'

class Simulation

	def initialize(options = {})

		@ticks = 1
		@num_floor = options[:num_floor]
		@num_people = options[:num_people]
		@max_ticks = options[:ticks]
		@elevator = Elevator.new(:floor_count=>@num_floor,:top_floor=>@num_people)
		@floors = Array.new
	end

	def clock_tick
		@ticks += 1
	end

	def start(options = {})
		p "Start"
		print @elevator.to_s, "\n"

		add_floors
		add_rand_person_floor(@elevator,@num_people)

		@building = Building.new(:floors=>@floors,:elevator=>@elevator)

		while @ticks < @max_ticks && ((@elevator.passengers.length > 0) || !@floors[0].people_queue.empty? || !@floors[1].people_queue.empty? || !@floors[2].people_queue.empty?)

			print_and_run

			if @ticks == 6
				add_rand_person_floor(@elevator,5)
			end

			clock_tick

			puts
		end

		print "Ran ",@ticks," ticks before finished, floors and elevators empty"
		puts

	end

	def print_and_run
		print "Tick ", @ticks,"\n"

		@building.run
		print @elevator.to_s

		if(@elevator.state==1) 
			print "Trying to go Up\n"
		else 
			print "Trying to go Down \n"
		end
	end

	def add_floors
		(1..@num_floor).each do |i|
			@floors << Floor.new(@elevator)
		end
	end


	def add_rand_person_floor(elevator,num_people)
		@people = create_rand_people(num_people)
		@people.each do |person|
			@rand = rand(0..(@floors.length)-1)
			if(person.intended_floor == (@rand+1))
				next
			end
			@floors[@rand].add_person(person,@elevator)
		print "Added person at floor ", @rand+1, " and he wants to go to floor " , person.intended_floor, "\n"
		end
	end

	def create_rand_people(x)

		@people = Array.new
		for i in 0..x
			person = Person.new(rand(1..@floors.length))
			@people << person
		end

		return @people

	end


end