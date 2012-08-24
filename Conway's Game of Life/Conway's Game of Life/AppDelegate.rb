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
    
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
        
        #Lock Some TableView functions
        @tableView.setAllowsColumnReordering(false)
        
        
        #Create Columns
        col = NSTableColumn.new().initWithIdentifier("0")
        @tableView.addTableColumn(col)
    end
end

