#
#  view_controller.rb
#  Conway's Game of Life
#
#  Created by Christopher Harper on 8/2/12.
#  Copyright 2012 Christopher Harper. All rights reserved.
#

require 'organism'
require 'world'
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
    attr_accessor :timer_interval
    attr_accessor :time_test
    
    def initialize
        @world = World.new
        @organisms = @world.cells
        @reproduceables = @world.reproduceables
        @template_selected = false
        @timer_interval = 1.0
        @time_test = false

        
        
    end
    
    def awakeFromNib
        
        index = 0
        @numberOfColumns = 54
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
        start_time = Time.now
        @tableView.reloadData
        end_time = Time.now
        puts " Tick Elapsed time = #{end_time - start_time}"
        @time_test = true
        
        
    end
    
    #Timer for time between ticks
    def startTimer(sender)
        if @timer.nil?
            @start_button.setEnabled false
            @stop_button.setEnabled true
            @time = 0.0
            @timer = NSTimer
            .scheduledTimerWithTimeInterval(@timer_interval,
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
        
        #Regluar function of clicking on a cell and spawning a single organism
        if(@template_selected == false)
            Organism.new(@world, sender.clickedColumn, sender.clickedRow, false)
        
        #If a template has been selected get the origin of the click and create stencile
        else
            @world.stencile(@template, sender.clickedColumn, sender.clickedRow)
            @template_selected = false
        end
        start_time = Time.now
        @tableView.reloadData
        end_time = Time.now
        puts " Spawn Elapsed time = #{end_time - start_time}"
            
    end
    
    
    def numberOfRowsInTableView(sender)
       38
    end
    
    def tableView(tableView, objectValueForTableColumn:column, row:row)
        #Empty text in the cells
    end
    
    def tableView(tableView, willDisplayCell:cell, forTableColumn:column, row:row)
        start_time = Time.now
        cell.setDrawsBackground true
        cell.column = column
        cell.row = row
        alive = checkForOrganism(column, row)
        cell.setBackgroundColor(alive ? NSColor.greenColor : NSColor.whiteColor)
        if(time_test)
            end_time = Time.now
            puts "TableView #{end_time - start_time}"
            @time_test = false
        end
            

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
 
    #Begin Process of spawning an organized group of organisms
    def stencile(sender)
        @template = Template.new(sender)
        @template_selected = true
    end
    
    #Take speed selection and make it useable by the timer
    def menuToSpeed(sender)
        if(sender.title == "Speed")
            #Do Nothing
        else
            @timer_interval = (1/sender.title.to_i)
        end
    end
        
end
