class Cell
	attr_accessor :x, :y

	def neighbor
		[]
	end
	def spawn_at(new_x,new_y)
		new_cell = Cell.new
		new_cell.x = new_x
		new_cell.y = new_y
		new_cell
	end
end
