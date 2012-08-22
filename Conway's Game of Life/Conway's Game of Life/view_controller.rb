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
    attr_accessor :buttonColor
    attr_accessor :teststring
    
    def initialize
        @world = World.new
        @teststring = "bergdy"
    end
    
    def tick(sender)
        world.tick!
        cells = world.cells
        textField.setStringValue(cells.count)
        
        
    end
    
    def create(sender)
        Organism.new(@world,0,0,false)
        Organism.new(@world,0,1,false)
        Organism.new(@world,0,2,false)
        Organism.new(@world,-1,0,false)
        Organism.new(@world,-1,1,false)
        #Organism.new(@world,2,0,false)
        #Organism.new(@world,3,0,false)
    end
    
    def colorChange(sender)
        @buttonColor = NSColor.redColor
    end
    
    def numberOfRowsInTableView(sender)
        7
    end
end
