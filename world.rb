class World

	attr_accessor :cells
	
	def initialize
		@cells = []
	end

	def tick!
		cells.each do |cell|
			if cell.neighbor.count < 2  #Rule 1
				cell.die!
			end
		end
	end

	
		

	
	
end
