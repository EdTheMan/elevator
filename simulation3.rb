require './Person.rb'
require './Building.rb'
require './Floor.rb'
require './Elevator.rb'

module Simulation
	@ticks = 0

	def clock_tick
		@ticks += 1
	end

 module_function :clock_tick

	def Simulation.start
		@elevator = Elevator.new(:floor_count=>3,:top_floor=>3)
		@people1 = Array.new
		@people2 = Array.new
		@people3 = Array.new

		for i in 0..5
			person = Person.new(1 + rand(2))
			person.call_elevator(@elevator)
			@people1 << person
		end
		for i in 0..5
			person = Person.new(1 + rand(2))
			person.call_elevator(@elevator)
			@people2 << person
		end
		for i in 0..5
			person = Person.new(1 + rand(2))
			person.call_elevator(@elevator)
			@people3 << person
		end
		floor1= Floor.new(@elevator,@people1)
		floor2= Floor.new(@elevator,@people2)
		floor3= Floor.new(@elevator,@people3)
		building = Building.new(:floors=>[floor1,floor2,floor3],:elevator=>@elevator)

		p "Start"
		print @elevator.to_s
		while @ticks < 30 && ((@elevator.passengers.length > 0) || !floor1.people_queue.empty? || !floor2.people_queue.empty? || !floor3.people_queue.empty?)
			print "Tick ", @ticks,"\n"

			building.run
			print @elevator.to_s
			if(@elevator.state==1) 
				print "Going Up\n"
			else print "Going Down\n" 
			end
			if @ticks == 10
				person = Person.new(1)
				person2 = Person.new(1)
				floor2.add_person(person)
				floor3.add_person(person2)
				person.call_elevator(@elevator)
				person2.call_elevator(@elevator)
			end
			clock_tick
		end

		print "Ran ",@ticks," ticks before finished"
		puts
	end

end

Simulation.start