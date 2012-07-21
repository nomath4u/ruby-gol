require 'rspec'
require_relative 'cell'
require_relative 'world'
require_relative 'reproduceable'
describe'game of life' do
	let(:world){World.new}
	context "cell methods" do
		subject { Cell.new(world, 0, 0, false) }
		it "spawn relative to" do
			cell = subject.spawn_at(5,5)
			cell.is_a?(Cell).should be_true
			cell.x.should == 5
			cell.y.should == 5
			cell.world.should == subject.world
		end

		it "detects north neighbor" do
			cell = Cell.new(world,0,1,false)
			subject.neighbor.count.should == 1
		end

		it "detects north east neighbor" do
			cell = Cell.new(world,1,1, false)
			subject.neighbor.count.should == 1
		end
		
		it "detects east neighbor" do
			cell = Cell.new(world,1,0,false)
			subject.neighbor.count.should == 1
		end

		it "detects southeast neighbor" do
			cell = Cell.new(world,1,-1, false)
			subject.neighbor.count.should == 1
		end

		it "detects south neighbor" do
			cell = Cell.new(world,0,-1,false)
			subject.neighbor.count.should == 1
		end

		it "detects southwest neighbor" do
			cell = Cell.new(world,-1,-1, false)
			subject.neighbor.count.should == 1
		end
	
		it "detects west neighbor" do
			cell = Cell.new(world,-1,0, false)
			subject.neighbor.count.should == 1
		end

		it "detects northwest neightbor" do
			cell = Cell.new(world,-1,1,false)
			subject.neighbor.count.should == 1
		end

		it "dies" do
			subject.die!
			subject.world.cells.should_not include(subject)
		end
	end
	it " Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population." do
	
		cell = Cell.new(world, false)
		new_cell = cell.spawn_at(2,0)
		world.tick!
		cell.should be_dead
	end

	it "Rule #2: Any live cell with two or three live neighbours lives on to the next genereation." do

		cell = Cell.new(world, false)
		new_cell = Cell.new(world,1,0,false)
		another_new_cell = Cell.new(world,0, 1,false)
		world.tick!
		cell.should be_alive
	end

	it"Rule #3: Any live cell with more than three neighbours dies, as if by overcrowding." do

		cell = Cell.new(world, false)
		new_cell = Cell.new(world,1,0,false)
		another_new_cell = Cell.new(world,0,1,false)
		third_new_cell = Cell.new(world,1,1,false)
		fourth_new_cell = Cell.new(world,-1, -1,false)
		world.tick!
		cell.should be_dead
	end

	it"Rule #4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction." do
		
		cell = Cell.new(world,false)
		new_cell = Cell.new(world, 1, 1, false) 
		another_new_cell = Cell.new(world, -1 ,1, false)
		world.cells.count.should == 3
		world.reproduceables.count.should == 0
		world.tick!
		world.reproduceables.count.should == 0
		world.protected_cells.count.should == 0
		world.cells.count.should == 2 #2 should die and one should spawn
	end
end
