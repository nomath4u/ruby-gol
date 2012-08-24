#
#  AppDelegate.rb
#  Conway's Game of Life
#
#  Created by Christopher Harper on 8/2/12.
#  Copyright 2012 Christopher Harper. All rights reserved.
#

require 'world'
require 'organism'

class AppDelegate
    attr_accessor :window
    attr_accessor :tableView
    attr_accessor :numberOfColumns
    
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
        index = 0
        @numberOfColumns = 11
        #Lock Some TableView functions
        @tableView.setAllowsColumnReordering false
        @tableView.setAllowsColumnSelection false
        
        
        #Create Columns
        @numberOfColumns.times do |c|
            col = NSTableColumn.new().initWithIdentifier("#{c}")
            col.setEditable false
            @tableView.addTableColumn(col)
        end
    end
end

