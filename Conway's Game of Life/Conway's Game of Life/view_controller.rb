#
#  view_controller.rb
#  Conway's Game of Life
#
#  Created by Christopher Harper on 8/2/12.
#  Copyright 2012 Christopher Harper. All rights reserved.
#

require 'organism'
require '~/Documents/Game_of_life/world'
require 'NSCellWithCoordinates'

class ViewController
    
    attr_accessor :window
    attr_accessor :table
    attr_accessor :world
    attr_accessor :organisms
    attr_accessor :textField
    attr_accessor :teststring
    attr_accessor :tableView
    attr_accessor :timesPressed
    attr_accessor :reproduceables
    
    def initialize
        @world = World.new
        @teststring = 'bergdy'
        @timesPressed = 0
        @organisms = @world.cells
        @reproduceables = @world.reproduceables
        
        
        
    end
    
    def awakeFromNib
        index = 0
        @numberOfColumns = 11
        #Lock Some TableView functions
        @tableView.setAllowsColumnReordering false
        @tableView.setAllowsColumnSelection false
        @tableView.setSelectionHighlightStyle NSTableViewSelectionHighlightStyleNone
        
        
        #Create Columns
        
        button_cell = NSCellWithCoordinates.new
        button_cell.setTarget self
        button_cell.setAction "spawn:"
        button_cell.setTitle ''
        @numberOfColumns.times do |c|
            col = NSTableColumn.new().initWithIdentifier("#{c}")
            col.setEditable false
            col.setDataCell button_cell
            @tableView.addTableColumn(col)
        end
    end
    
    def tick(sender)
        @world.tick!
        @organisms = @world.cells
        
        #Update the Table
        @tableView.reloadData
        
        
    end
    
    def spawn(sender)
        
        Organism.new(@world, sender.clickedColumn, sender.clickedRow, false)
        @tableView.reloadData
    end
    
    def create(sender)
        
        #Create test organisms
        Organism.new(@world,6,10,false)
        Organism.new(@world,6,9,false)
        Organism.new(@world,7,10,false)
        Organism.new(@world,7,9,false)
        Organism.new(@world,7,8,false)
        
        #Catch the view controller up
        @organisms = @world.cells
    
    #Table View
    end
    
    def additionalColumn(sender)
        @timesPressed += 1
        
        if(@timesPressed > 6)
            @timesPressed = 0
        end
        
       @tableView.reloadData
        
    end
    
    def numberOfRowsInTableView(sender)
        19
    end
    
    def tableView(tableView, objectValueForTableColumn:column, row:row)
        #Empty text in the cells
    end
    
    def tableView(tableView, willDisplayCell:cell, forTableColumn:column, row:row)
        cell.setDrawsBackground true
        cell.column = column
        cell.row = row
        alive = checkForOrganism(column, row)
        cell.setBackgroundColor(alive ? NSColor.greenColor : NSColor.whiteColor)
        puts "(#{column.identifier}, #{row}) is #{alive ? 'alive' : 'dead'}"
    end
    
    def checkForOrganism(column, row)
        @organisms.detect do |organism|
            "#{organism.x}" == column.identifier && organism.y == row
        end
    end
            
end
