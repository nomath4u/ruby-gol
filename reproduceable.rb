class Reproduceable
	
	attr_accessor :world,  :x, :y
    attr_accessor :neighbors
	def initialize(world, x=0, y=0)
		@x = x
		@y = y
		@world =world
		world.reproduceables << self
	end


	def cell_neighbor
		@neighbors = []
		world.cells.each do |cell|
			#Cell to the North	
			if self.x == cell.x && self.y == cell.y - 1
				@neighbors << cell
			end

			#Cell to the Northeast
			if self.x == cell.x - 1 && self.y == cell.y - 1
				@neighbors << cell
			end

			#Cell to the East
			if self.x == cell.x - 1 && self.y == cell.y
				@neighbors << cell
			end

			#Cell to the Southeast
			if self.x == cell.x - 1 && self.y == cell.y + 1
				@neighbors << cell
			end

			#Cell to the South
			if self.x == cell.x && self.y == cell.y + 1
				@neighbors << cell
			end
			
			#Cell to the Southwest
			if self.x == cell.x + 1 && self.y == cell.y + 1
				@neighbors << cell
			end
			
			#Cell to the West
			if self.x == cell.x + 1 && self.y == cell.y
				@neighbors << cell
			end

			#Cell to the Northwest
			if self.x == cell.x + 1 && self.y == cell.y - 1
				@neighbors << cell
			end
		end
	end

	
	def self.spawn_at(world, x, y)
		 Reproduceable.new(world, x, y)
	end
end
