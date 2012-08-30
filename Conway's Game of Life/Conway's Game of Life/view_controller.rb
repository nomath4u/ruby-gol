#
#  view_controller.rb
#  Conway's Game of Life
#
#  Created by Christopher Harper on 8/2/12.
#  Copyright 2012 Christopher Harper. All rights reserved.
#

require 'organism'
require '~/Documents/Game_of_life/Conway\'s Game of Life/Conway\'s Game of Life/world'
require 'NSCellWithCoordinates'

class ViewController
    
    attr_accessor :window
    attr_accessor :table
    attr_accessor :world
    attr_accessor :organisms
    attr_accessor :tableView
    attr_accessor :reproduceables
    attr_accessor :start_button, :stop_button
    attr_accessor :template_selected
    attr_accessor :template
    
    def initialize
        @world = World.new
        @organisms = @world.cells
        @reproduceables = @world.reproduceables
        @template_selected = false
        
        
    end
    
    def awakeFromNib
        index = 0
        @numberOfColumns = 52
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
            col.setWidth 16.0
            col.setDataCell button_cell
            @tableView.addTableColumn(col)
        end
    end
    
    def tick(sender)
        @world.tick!
        @organisms = @world.cells
        
        #End timer if no cells
        if(@organisms.count == 0)
            @timer.invalidate
            @start_button.setEnabled true
            @stop_button.setEnabled false
        end
        
        #Update the Table
        @tableView.reloadData
        
        
    end
    
    def startTimer(sender)
        if @timer.nil?
            @start_button.setEnabled false
            @stop_button.setEnabled true
            @time = 0.0
            @timer = NSTimer
            .scheduledTimerWithTimeInterval(1.0,
                                            target: self,
                                            selector: "tick:",
                                            userInfo: nil,
                                            repeats: true)
        end
    end
    
    def stopTimer(sender)
        if @timer
            @start_button.setEnabled true
            @stop_button.setEnabled false
            @timer.invalidate
            @timer = nil
        end
    end
        
    
    def spawn(sender)
        
        #Regluar function of clicking on a cell
        if(@template_selected == false)
            Organism.new(@world, sender.clickedColumn, sender.clickedRow, false)
        
        #If a template has been selected get the origin of the click
        else
            @world.stencile(@template, sender.clickedColumn, sender.clickedRow)
            @template_selected = false
        end
        @tableView.reloadData
            
    end
    
    
    def numberOfRowsInTableView(sender)
       43
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
    end
    
    def checkForOrganism(column, row)
        @organisms.detect do |organism|
            "#{organism.x}" == column.identifier && organism.y == row
        end
    end
    
    def clearBoard(sender)
        @organisms.each {|organism| organism.die!}
        @organisms = world.cells
        @tableView.reloadData
    end
    
    def stencile(sender)
        @template = Template.new
        @template_selected = true
        #@world.stencile(template)
        #@tableView.reloadData
    end
        
end
