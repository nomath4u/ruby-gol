#
#  Template.rb
#  Conway's Game of Life
#
#  Created by Christopher Harper on 8/27/12.
#  Copyright 2012 Christopher Harper. All rights reserved.
#

require '~/Documents/Game_of_Life/Conway\'s Game of Life/Conway\'s Game of Life/coordinate'

class Template
    attr_accessor :organism_locations
    
    def initialize
        locations = []
       setLocations(locations)
        
    end
    
    def setLocations(locations)
        
        #Blinker
        locations[0] = Coordinate.new(0,0)
        locations[1] = Coordinate.new(0,1)
        locations[2] = Coordinate.new(0,2)
        @organism_locations = locations
    end
end

