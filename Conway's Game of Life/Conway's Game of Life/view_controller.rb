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
    attr_accessor :text
    attr_accessor :table
    attr_accessor :world
    attr_accessor :cells
    attr_accessor :textField
    attr_accessor :buttonColor
    attr_accessor :teststring
    attr_accessor :tableView
    attr_accessor :timesPressed
    
    def initialize
        @world = World.new
        @teststring = 'bergdy'
        @timesPressed = 0
        
        
        
    end
    
    def tick(sender)
        world.tick!
        @cells = world.cells
        textField.setStringValue(cells.count)
        
        #Update the Table
        @tableView.reloadData
        
        
    end
    
    def create(sender)
        Organism.new(@world,0,0,false)
        Organism.new(@world,0,1,false)
        Organism.new(@world,0,2,false)
        #Organism.new(@world,-1,0,false)
        #Organism.new(@world,-1,1,false)
        #Organism.new(@world,2,0,false)
        #Organism.new(@world,3,0,false)
        
        #Display Created Cells without !tick
        @tableView.reloadData
    end
    
    
    #Table View
    
    def additionalColumn(sender)
        @timesPressed += 1
        
        if(@timesPressed > 6)
            @timesPressed = 0
        end
        
       @tableView.reloadData
        
    end
    
    def numberOfRowsInTableView(sender)
        7
    end
    
    def tableView(tableView, objectValueForTableColumn:column, row:row)
        if(column.identifier == "0" && row == @timesPressed)
            '0'
        
        else
            @teststring
        end
    end
    
    def tableView(tableView, willDisplayCell:cell, forTableColumn:column, row:row)
        cell.setDrawsBackground true
        if(column.identifier == "0" && row == @timesPressed)
            cell.setBackgroundColor NSColor.redColor
        else
            cell.setBackgroundColor NSColor.whiteColor
        end
    end
end
