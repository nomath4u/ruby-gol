require 'reproduceable'
require 'world'

class Organism
	attr_accessor :world,  :x, :y, :full_neighbor_north
	attr_accessor :full_neighbor_northeast, :full_neighbor_east
	attr_accessor :full_neighbor_southeast, :full_neighbor_south
	attr_accessor :full_neighbor_southwest, :full_neighbor_west
	attr_accessor :full_neighbor_northwest
	attr_accessor :safe
   	attr_accessor :neighbors

	def initialize(world, x=0, y=0, safe)
		@x = x
		@y = y
		@world =world
		@full_neighbor_north = false
		@full_neighbor_northeast = false
		@full_neighbor_east = false
		@full_neighbor_southeast = false
		@full_neighbor_south = false
		@full_neighbor_southwest = false
		@full_neighbor_west = false
		@full_neighbor_northwest = false
		@safe = safe
	        @neighbors = []
	
		#Only add cells to world as a cell if not protected
		if(@safe == false)
			@world.cells << self
		
		#Add cell as protected cell
		elsif(@safe == true)
			@world.safe_cells << self
		end
        
	end

	def neighbor
		@neighbors = []
		@world.cells.each do |cell|
			#Cell to the North	
			if ((self.x == cell.x) && (self.y == cell.y - 1))
				@neighbors << cell
				@full_neighbor_north = true
			end

			#Cell to the Northeast
			if self.x == cell.x - 1 && self.y == cell.y - 1
				@neighbors << cell
				@full_neighbor_northeast = true
			end

			#Cell to the East
			if self.x == cell.x - 1 && self.y == cell.y
				@neighbors << cell
				@full_neighbor_east = true
			end

			#Cell to the Southeast
			if self.x == cell.x - 1 && self.y == cell.y + 1
				@neighbors << cell
				@full_neighbor_southeast = true
			end

			#Cell to the South
			if self.x == cell.x && self.y == cell.y + 1
				@neighbors << cell
				@full_neighbor_south = true
			end
			
			#Cell to the Southwest
			if self.x == cell.x + 1 && self.y == cell.y + 1
				@neighbors << cell
				@full_neighbor_southwest = true
			end
			
			#Cell to the West
			if self.x == cell.x + 1 && self.y == cell.y
				@neighbors << cell
				@full_neighbor_west = true
			end

			#Cell to the Northwest
			if self.x == cell.x + 1 && self.y == cell.y - 1
				@neighbors << cell
				@full_neighbor_northwest = true
			end
		end
			
		world.reproduceables.each do |reproduceable|

			#Reproduceable to the North	
			if ((self.x == reproduceable.x) && (self.y == reproduceable.y - 1))
				@full_neighbor_north = true	
			end

			#Reproduceable to the Northeast
			if self.x == reproduceable.x - 1 && self.y == reproduceable.y - 1
				@full_neighbor_northeast = true
			end

			#Reproduceable to the East
			if self.x == reproduceable.x - 1 && self.y == reproduceable.y
				@full_neighbor_east = true
			end

			#Reproduceable to the Southeast
			if self.x == reproduceable.x - 1 && self.y == reproduceable.y + 1
				@full_neighbor_southeast = true
			end

			#Reproduceable to the South
			if self.x == reproduceable.x && self.y == reproduceable.y + 1
				@full_neighbor_south = true
			end
			
			#Reproduceable to the Southwest
			if self.x == reproduceable.x + 1 && self.y == reproduceable.y + 1
				@full_neighbor_southwest = true
			end
			
			#Reproduceable to the West
			if self.x == reproduceable.x + 1 && self.y == reproduceable.y
				@full_neighbor_west = true
			end

			#Reproduceable to the Northwest
			if self.x == reproduceable.x + 1 && self.y == reproduceable.y - 1
				@full_neighbor_northwest = true
			end
		end
	end

	def add_reproduceable
		#Add Reproduceable to the north
		if(@full_neighbor_north == false)
			Reproduceable.spawn_at(world,self.x,(self.y + 1))
			@full_neighbor_north = true
		end

		#Add Reproduceable to the northeast
		if(@full_neighbor_northeast == false)
			Reproduceable.spawn_at(world,(self.x + 1),(self.y + 1))
			@full_neighbor_northeast = true
		end

		#Add Reproduceable to the east
		if(@full_neighbor_east == false)
			Reproduceable.spawn_at(world,(self.x + 1),self.y)
			@full_neighbor_east = true
		end

		#Add Reproduceable to the southeast
		if(@full_neighbor_southeast == false)
			Reproduceable.spawn_at(world,(self.x + 1),(self.y - 1))
			@full_neighbor_southeast = true
		end

		#Add Reproduceable to the south
		if(@full_neighbor_south == false)
			Reproduceable.spawn_at(world,self.x,(self.y - 1))
			@full_neighbor_south = true
		end

		#Add Reproduceable to the southwest
		if(@full_neighbor_southwest == false)
			Reproduceable.spawn_at(world,(self.x - 1),(self.y - 1))
			@full_neighbor_southwest = true
		end

		#Add Reproduceable to the west
		if(@full_neighbor_west == false)
			Reproduceable.spawn_at(world,(self.x - 1),self.y)
			@full_neighbor_west = true
		end

		#Add Reproduceable to the northwest
		if(@full_neighbor_northwest == false)
			Reproduceable.spawn_at(world,(self.x - 1),(self.y + 1))
			@full_neighbor_northwest = true
		end
		
	end

	def spawn_at(x,y)
		 Organism.new(world, x, y, true)
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
