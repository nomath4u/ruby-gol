class Reproducable
	
	attr_accessor :world,  :x, :y
	def initialize(world, x=0, y=0)
		@x = x
		@y = y
		@world =world
		world.reproduceables << self
	end

	
	def spawn_at(x,y)
		 Reproduceable.new(world, x, y)
	end
end
