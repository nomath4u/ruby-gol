//
//  main.m
//  Conway's Game of Life
//
//  Created by Christopher Harper on 8/2/12.
//  Copyright (c) 2012 Christopher Harper. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
    return macruby_main("rb_main.rb", argc, argv);
}
