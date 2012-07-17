require 'rspec'
require_relative 'cell'

describe'game of life' do
	context "cell methods" do
		subject { Cell.new }
		it "spawn relative to" do
			cell = subject.spawn_at(5,5)
			cell.is_a?(Cell).should be_true
			cell.x.should == 5
			cell.y.should == 5
		end
	end
	it " Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population." do
	
		cell = Cell.new
		cell.neighbor.count.should  == 0
	end
end
