class World

	attr_accessor :cells , :reproduceables, :safe_cells
	
	def initialize
		@cells = []
		@reproduceables = []
		@safe_cells = []
	end

	def tick!
		#Add reproduceables around each cell and set cell neighbor counts for each cell
		cells.each do |cell|
			neighbor_cell_count  = cell.neighbor.count
			cell.add_reproduceable			
		end

		#Spawn Cells
		reproduceables.each do |reproduceable|
			#Spawn protected so that they don't count as a neighbor or get killed until the next tick!
			if (reproduceable.cell_neighbor.count  == 3) #Rule 4
				spawn_cell(reproduceable.x, reproduceable.y, true)
			end
			@reproduceables -= [reproduceable] #Remove the reproduceable after being evaluated
		end

		#Kill off cells
		cells.each do |cell|
			
			if ((cell.neighbor.count < 2) && (cell.safe == false))  #Rule 1
				cell.die!
			end
		
			if ((cell.neighbor.count > 3) && (cell.safe == false)) # Rule 3
				cell.die!
			end
		end

		#Unprotect all protected_cells
		safe_cells.each do |protectedcell|
			
			@cells << protectedcell
			@safe_cells -= [protectedcell]
		end
	end

	def spawn_cell(x , y, safe)
		Cell.new(self, x , y, safe)
	end
end
