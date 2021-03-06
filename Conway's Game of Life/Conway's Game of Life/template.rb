#
#  Template.rb
#  Conway's Game of Life
#
#  Created by Christopher Harper on 8/27/12.
#  Copyright 2012 Christopher Harper. All rights reserved.
#

require 'coordinate'
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
    
    #Get and parse stencile file based on sender
    
    #Using $0 because __FILE__ gets compiled incorrectly in macruby
    temp = File.expand_path("../#{sender.title}.json", $0)
    
    contents = File.read(temp)
    iteration = 0
    info = JSON.parse(contents)
    
    #Extract organism coordinates
    info['points'].each do |coord|
      locations[iteration] = Coordinate.new(coord['x_coordinate'], coord['y_coordinate'])
      iteration += 1
    end
    
    @organism_locations = locations
  end
end

