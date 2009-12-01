//
//  LED.m
//  Robo
//
//  Created by Thijs Scheepers on 10-01-09.
//  Copyright 2009 Web6.nl Diensten. All rights reserved.
//

#import "LED.h"


@implementation LED
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
		
		[self setSize:NSMakeSize(50,50)];
		[self setLabel:@""];
		[self setDescription:@"Een eenvoudige outlet in de vorm van een lamp."];
		[self setPosInView:positionInView];
		[self setIsDisplay:TRUE];
		[self loadDisplayParts];
		image = [NSImage imageNamed:@"led"];
	}
	return self;
}

-(void)loadDisplayParts {
	displayParts = [[NSMutableArray alloc] init];
	
	displayPart* part_LED = [[displayPart alloc] initAtPos:NSMakePoint(15,10) position:9 ];
	[displayParts addObject:part_LED];
}

-(void)updateAllPorts {
	id port01 = [ports objectAtIndex:0];
	if([port01 high]) {
		[[displayParts objectAtIndex:0] setHigh:YES];
	}
	else {
		[[displayParts objectAtIndex:0] setHigh:NO];
	}
}

- (NSArray*)displayParts {
	return displayParts;
}

-(NSString*)name {
	return @"LED";
}
@end