#
#  Coordinate.rb
#  Conway's Game of Life
#
#  Created by Christopher Harper on 8/27/12.
#  Copyright 2012 Christopher Harper. All rights reserved.
#

class Coordinate
    attr_accessor :x , :y
    
    def initialize(x , y)
        @x = x
        @y = y
    end

end
