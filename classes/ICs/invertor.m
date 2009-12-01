//
//  invertor.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 07-01-09.
//  Copyright 2009 Mote of Life. All rights reserved.
//

#import "invertor.h"


@implementation invertor
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
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint(40, 15) 
										 forObject: self ];
		[ports addObject:port02];
		
		[self setSize:NSMakeSize(50,50)];
		[self setLabel:@"INV"];
		
		[self setDescription:@"Hoog wordt laag, laag wordt hoog"];
		[self setPosInView:positionInView];
	}
	return self;
}

-(void)updateAllPorts {
	id port01 = [ports objectAtIndex:0];
	id port02 = [ports objectAtIndex:1];
		if([port01 high]) {
			[port02 setHigh:FALSE];
		}
		else {
			[port02 setHigh:TRUE];
		}
}

-(NSString*)name {
	return @"Inverter";
}
@end
