
class World

	attr_accessor :cells , :reproduceables, :safe_cells
	
	def initialize
		@cells = []
		@reproduceables = []
		@safe_cells = []
	end

	def tick!
        
        #Add reproduceables around each cell and set cell neighbor counts for each cell
		@cells.each do |cell|
			cell.neighbor
			cell.add_reproduceable			
		end

		#Spawn Cells
		reproduceables.each do |reproduceable|
            reproduceable.cell_neighbor
			#Spawn protected so that they don't count as a neighbor or get killed until the next tick!
			if (reproduceable.neighbors.count  == 3) #Rule 4
				spawn_cell(reproduceable.x, reproduceable.y, true)
			end
			self.reproduceables -= [reproduceable] #Remove the reproduceable after being evaluated
		end

		#Kill off cells
		@cells.each do |cell|
			
			if ((cell.neighbors.count < 2) && (cell.safe == false))  #Rule 1
				cell.die!
			end
		
			if ((cell.neighbors.count > 3) && (cell.safe == false)) # Rule 3
				cell.die!
			end
		end

		#Unprotect all protected_cells
		@safe_cells.each do |protectedcell|
			protectedcell.safe = false			
			@cells << protectedcell
			@safe_cells -= [protectedcell]
		end
        
        #Make all cells not have full neighbors
        @cells.each do |cell|
            cell.full_neighbor_north = false
            cell.full_neighbor_northeast = false
            cell.full_neighbor_east = false
            cell.full_neighbor_southeast = false
            cell.full_neighbor_south = false
            cell.full_neighbor_southwest = false
            cell.full_neighbor_west = false
            cell.full_neighbor_northwest = false
        end
        
	end

	def spawn_cell(x , y, safe)
		Organism.new(self, x , y, safe)
	end
    
    #Spawn Cells in accordance to the template
    def stencile(template, origin_x, origin_y)
        
        template.organism_locations.each do |coordinate|
            spawn_cell((coordinate.x + origin_x), (coordinate.y + origin_y), false)
        end
    end
end
