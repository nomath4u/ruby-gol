#
#  Template.rb
#  Conway's Game of Life
#
#  Created by Christopher Harper on 8/27/12.
#  Copyright 2012 Christopher Harper. All rights reserved.
#

require '~/Documents/Game_of_Life/Conway\'s Game of Life/Conway\'s Game of Life/coordinate'
require 'json'


class Template
    attr_accessor :organism_locations
    attr_accessor :sender
    def initialize(sender)
        @sender = sender
        locations = []
        setLocations(locations)
        
    end
    
    def setLocations(locations)
        
        #Blinker
        json = File.read("/Users/Chris/Documents/Game_Of_Life/Conway\'s Game of Life/Conway\'s Game of Life/#{@sender.title}.json")
        iteration = 0
        info = JSON.parse(json)
        
        info.each do |points|
            points[1].each do |coord|
                locations[iteration] = Coordinate.new(coord['x_coordinate'], coord['y_coordinate'])
                iteration += 1
            end
        end
        
        @organism_locations = locations
    end
end

