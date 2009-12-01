//
//  voltage.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 07-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "voltage.h"


@implementation voltage

-(id)initAtPosition:(NSPoint)positionInView {
	self = [super init];
	if(self) {
		//init van alle poorten, in de array stoppen
		port* port01 = [[port alloc] initWithLabel: @""
											number: 1
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint(70, 5) 
										 forObject: self ];
		[ports addObject:port01];
		
		port* port02 = [[port alloc] initWithLabel: @""
											number: 2
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(70, 30) 
										 forObject: self ];
		[port02 setSpecialInput:YES];
		[ports addObject:port02];
		
		[self setSize:NSMakeSize(80,55)];
		[self setLabel:@"VOEDING"];
		[self setDescription:@"Een voeding, één hoge uitgang"];
		[self setPosInView:positionInView];
		image = [NSImage imageNamed:@"spoort"];
	}
	return self;
}

-(void)updateAllPorts {
	
}

-(NSString*)name {
	return @"Voeding";
}

@end
