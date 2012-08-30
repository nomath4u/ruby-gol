require 'rspec'
require_relative 'organism'
require_relative 'world'
require_relative 'reproduceable'
require_relative 'template'
describe'game of life' do
	let(:world){World.new}
	context "cell methods" do
		subject { Organism.new(world, 0, 0, false) }
=begin
		it "spawn relative to" do
			cell = subject.spawn_at(5,5)
			cell.is_a?(Organism).should be_true
			cell.x.should == 5
			cell.y.should == 5
			cell.world.should == subject.world
		end

		it "detects north neighbor" do
			cell = Organism.new(world,0,1,false)
			subject.neighbors.count.should == 1
		end

		it "detects north east neighbor" do
			cell = Organism.new(world,1,1, false)
			subject.neighbors.count.should == 1
		end
		
		it "detects east neighbor" do
			cell = Organism.new(world,1,0,false)
			subject.neighbors.count.should == 1
		end

		it "detects southeast neighbor" do
			cell = Organism.new(world,1,-1, false)
			subject.neighbors.count.should == 1
		end

		it "detects south neighbor" do
			cell = Organism.new(world,0,-1,false)
			subject.neighbors.count.should == 1
		end

		it "detects southwest neighbor" do
			cell = Organism.new(world,-1,-1, false)
			subject.neighbors.count.should == 1
		end
	
		it "detects west neighbor" do
			cell = Organism.new(world,-1,0, false)
			subject.neighbors.count.should == 1
		end

		it "detects northwest neightbor" do
			cell = Organism.new(world,-1,1,false)
			subject.neighbors.count.should == 1
		end
=end
		it "dies" do
			subject.die!
			subject.world.cells.should_not include(subject)
		end
	end
	it " Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population." do
	
		cell = Organism.new(world, false)
		new_cell = Organism.new(world,1,0,false)
		world.tick!
		cell.should be_dead
	end

	it "Rule #2: Any live cell with two or three live neighbours lives on to the next genereation." do

		cell = Organism.new(world, false)
		new_cell = Organism.new(world,1,0,false)
		another_new_cell = Organism.new(world,0, 1,false)
		world.tick!
		cell.should be_alive
		new_cell.should be_alive
		another_new_cell.should be_alive
	end

	it"Rule #3: Any live cell with more than three neighbours dies, as if by overcrowding." do

		cell = Organism.new(world, false)
		new_cell = Organism.new(world,1,0,false)
		another_new_cell = Organism.new(world,0,1,false)
		third_new_cell = Organism.new(world,1,1,false)
		fourth_new_cell = Organism.new(world,-1, -1,false)
		world.tick!
		cell.should be_dead
		fourth_new_cell.should be_dead
		new_cell.should be_alive
		another_new_cell.should be_alive
		third_new_cell.should be_alive
	end

	it"Rule #4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction." do
		
		cell = Organism.new(world,false)
		new_cell = Organism.new(world, 1, 1, false) 
		another_new_cell = Organism.new(world, -1 ,1, false)
		world.cells.count.should == 3
		world.reproduceables.count.should == 0
		world.tick!
		world.reproduceables.count.should == 0
		world.safe_cells.count.should == 0
		world.cells.count.should == 2 #2 should die and one should spawn
	end

	it"Large scale test" do

		cell = Organism.new(world,false)
		new_cell = Organism.new(world, 1, 0, false)
		another_new_cell = Organism.new(world, 0, 1, false)
		fourth_new_cell = Organism.new(world, 1, 1, false)
		fifth_new_cell = Organism.new(world, 1, 2, false)
		world.tick!
		world.cells.count.should == 5
		world.safe_cells.count.should == 0
		world.tick!
		world.reproduceables.count.should == 0
		world.safe_cells.count.should == 0
		world.cells.count.should == 3
		world.tick!
		world.cells.count.should == 2
		world.tick!
		world.cells.count.should == 0
	end

	it "Template test" do
		template = Template.new
		world.stencile(template)
		world.cells.count.should == template.organism_locations.count
	end
		
end
