class World

	attr_accessor :cells , :reproduceables
	
	def initialize
		@cells = []
		@reproduceables = []
	end

	def tick!
		cells.each do |cell|
			if cell.neighbor.count < 2  #Rule 1
				cell.die!
			end
		
			if cell.neighbor.count > 3 # Rule 3
				cell.die!
			end
		end
	end

	
		

	
	
end
