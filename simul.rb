require './simulation.rb'

module Sim

	@simulation = Simulation.new(:ticks=>30,:num_people=>5,:num_floor=>5)
	@simulation.start
end