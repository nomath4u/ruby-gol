#
#  view_controller.rb
#  Conway's Game of Life
#
#  Created by Christopher Harper on 8/2/12.
#  Copyright 2012 Christopher Harper. All rights reserved.
#

require 'organism'
require '~/Documents/Game_of_life/world'

class ViewController
    attr_accessor :window
    attr_accessor :world
    attr_accessor :cells
    attr_accessor :textField
    
    def initialize
        @world = World.new
    end
    
    def tick(sender)
        @world.tick!
        @cells = world.cells
        textField.setStringValue(@cells)
        
        
    end
    
    def create(sender)
        Organism.new(world,0,0,false)
    end
end
