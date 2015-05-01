require './simulation.rb'

module Sim

	@simulation = Simulation.new
	@simulation.start(:ticks=>30,:num_people=>5,:num_floor=>5)
end