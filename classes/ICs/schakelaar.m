//
//  schakelaar.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 11-01-09.
//  Copyright 2009 Mote of Life. All rights reserved.
//

#import "schakelaar.h"


@implementation schakelaar

-(id)initAtPosition:(NSPoint)positionInView {
	self = [super init];
	if(self) {
		//init van alle poorten, in de array stoppen
		port* port01 = [[port alloc] initWithLabel: @""
											number: 1
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(-10, 15) 
										 forObject: self ];
		[ports addObject:port01];
		
		port* port02 = [[port alloc] initWithLabel: @""
											number: 2
											  high: FALSE
											 input: FALSE 
											 point: NSMakePoint(60, 15) 
										 forObject: self ];
		[ports addObject:port02];
		
		[self setSize:NSMakeSize(70,50)];
		[self setLabel:@"KNOP"];
		[self setDescription:@"Een schakelaar met drukknop"];
		[self setPosInView:positionInView];
		
		image = [NSImage imageNamed:@"interactief"];
		
		colorState = [NSColor grayColor];
		state = 0;
		
		knop = NSMakeRect(20, 10, 30, 30);
		[self setHasButton:TRUE];
	}
	return self;
	
}

-(void)updateAllPorts {
	if(state == 0 || state == 1) {
		[[ports objectAtIndex:1] setHigh:NO];
	}
	else if((state == 2 || state == 3) && [[ports objectAtIndex:0] high]) {
		[[ports objectAtIndex:1] setHigh:YES];
	}
}

-(void)switchButton {
	// 0 -> 1 -> 2 -> 3 <- 0
	++state; 
	if(state == 4) {
		state = 0;
	}
	
	switch(state) {
		case 0: 
			colorState = [NSColor grayColor];
			break;
		case 1: 
			colorState = [NSColor darkGrayColor];
			break;
		case 2: 
			colorState = [NSColor redColor];
			break;
		case 3: 
			colorState = [NSColor colorWithCalibratedRed:0.5 green:0.0 blue:0.0 alpha:1.0];
			break;
	}
}

-(NSString*)name {
	return @"Schakelaar";
}

@end
