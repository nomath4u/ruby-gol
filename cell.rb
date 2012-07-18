class Cell
	attr_accessor :world,  :x, :y
	def initialize(world, x=0, y=0)
		@x = x
		@y = y
		@world =world
		world.cells << self
	end
	def neighbor
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
		@neighbors
	end
	def spawn_at(x,y)
		 Cell.new(world, x, y)
	end

	def die!
	world.cells -= [self]
	end

	def dead?
		!world.cells.include?(self)
	end

	def alive?
		world.cells.include?(self)
	end
end
