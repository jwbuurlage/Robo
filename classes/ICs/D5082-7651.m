//
//  5082-7651.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 08-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "D5082-7651.h"


@implementation D_5082_7651
-(id)initAtPosition:(NSPoint)positionInView {
	self = [super init];
	if(self) {
		//init van alle poorten, in de array stoppen
		int portNumber = 1;
		
		//port 1
		port* port01 = [[port alloc] initWithLabel: @"a"
											number: 1
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(-10, (portNumber * 30)) 
										 forObject: self ];
		[ports addObject:port01];
		++portNumber;
		
		//port 2
		port* port02 = [[port alloc] initWithLabel: @"f"
											number: 2
											  high: FALSE
											 input: TRUE
											 point: NSMakePoint(-10, (portNumber * 30)) 
										 forObject: self ];
		[ports addObject:port02];
		++portNumber;
		
		//port 3		
		port* port03 = [[port alloc] initWithLabel: @"CA"
											number: 3
											  high: FALSE
											 input: TRUE
											 point: NSMakePoint(-10, (portNumber * 30)) 
										 forObject: self ];
		[ports addObject:port03];
		++portNumber;
		
		//port 4		
		port* port04 = [[port alloc] initWithLabel: @""
											number: 4
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(-10, (portNumber * 30)) 
										 forObject: self ];
		
		[ports addObject:port04];
		++portNumber;
		
		//port 5		
		port* port05 = [[port alloc] initWithLabel: @""
											number: 5
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(-10, (portNumber * 30)) 
										 forObject: self ];
		
		[ports addObject:port05];		
		++portNumber;
		
		//port 6		
		port* port06 = [[port alloc] initWithLabel: @"NC"
											number: 6
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(-10, (portNumber * 30)) 
										 forObject: self ];
		
		[ports addObject:port06];
		++portNumber;
		
		//port 7		
		port* port07 = [[port alloc] initWithLabel: @"e"
											number: 7
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(-10, (portNumber * 30)) 
										 forObject: self ];
		
		[ports addObject:port07];
		++portNumber;
		
		//port 8		
		port* port08 = [[port alloc] initWithLabel: @"d"
											number: 8
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(110, 210 + (8 - portNumber) * 30)
										 forObject: self ];
		
		[ports addObject:port08];
		++portNumber;
		
		//port 9		
		port* port09 = [[port alloc] initWithLabel: @"DP"
											number: 9
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(110, 210 + (8 - portNumber) * 30)
										 forObject: self ];
		
		[ports addObject:port09];
		++portNumber;
		
		//port 10		
		port* port10 = [[port alloc] initWithLabel: @"c"
											number: 10
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(110, 210 + (8 - portNumber) * 30)
										 forObject: self ];
		
		[ports addObject:port10];
		++portNumber;
		
		//port 11		
		port* port11 = [[port alloc] initWithLabel: @"g"
											number: 11
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(110, 210 + (8 - portNumber) * 30) 
										 forObject: self ];
		
		[ports addObject:port11];
		++portNumber;
		
		//port 12		
		port* port12 = [[port alloc] initWithLabel: @""
											number: 12
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(110, 210 + (8 - portNumber) * 30)
										 forObject: self ];
		
		[ports addObject:port12];
		++portNumber;
		
		//port 13		
		port* port13 = [[port alloc] initWithLabel: @"b"
											number: 13
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(110, 210 + (8 - portNumber) * 30)
										 forObject: self ];
		
		[ports addObject:port13];
		++portNumber;
		
		//port 14		
		port* port14 = [[port alloc] initWithLabel: @"5V"
											number: 14
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(110, 210 + (8 - portNumber) * 30)
										 forObject: self ];
		
		[ports addObject:port14];
		
		
		/* NSString* backgroundFile = @"/SN7400_bg.png";		
		 NSImage* background = [[NSImage alloc] initWithContentsOfFile:backgroundFile];
		 [self setBackgroundImage:background]; */
		//positie geven
		[self setSize:NSMakeSize(120, 260)];
		[self setPosInView:positionInView];
		[self setLabel:@"5082-7651"];
		[self setIsDisplay:TRUE];
		[self setDescription:@"Een eenvoudig display"];
		
		[self loadDisplayParts];
	}
	return self;
}

-(void)updateAllPorts {
	//require 5V to be high
	port* highPort = [ports objectAtIndex:13];
	if([highPort high] == FALSE) {
		for(port* output in ports) {
			if(![output input]) {
				[output setHigh:FALSE];
			}
		}
		for(displayPart* display in displayParts) {
			[display setHigh:FALSE];
		}
	}
	else {
	//5V is aangesloten, good to go!
	//no outputs, instead update displays:
	//part a
	port* port_a = [ports objectAtIndex:0];
	displayPart* part_a = [displayParts objectAtIndex:0];
	if([port_a high]) {
		[part_a setHigh:YES];
	}
	else {
		[part_a setHigh:NO];
	}
	
	//part b
	port* port_b = [ports objectAtIndex:12];
	displayPart* part_b = [displayParts objectAtIndex:1];	
	if([port_b high]) {
		[part_b setHigh:YES];
	}
	else {
		[part_b setHigh:NO];
	}
	
	//part c
	port* port_c = [ports objectAtIndex:9];
	displayPart* part_c = [displayParts objectAtIndex:2];	
	if([port_c high]) {
		[part_c setHigh:YES];
	}
	else {
		[part_c setHigh:NO];
	}
	
	//part_d
	port* port_d = [ports objectAtIndex:7];
	displayPart* part_d = [displayParts objectAtIndex:3];	
	if([port_d high]) {
		[part_d setHigh:YES];
	}
	else {
		[part_d setHigh:NO];
	}
	
	//part_e
	port* port_e = [ports objectAtIndex:6];
	displayPart* part_e = [displayParts objectAtIndex:4];	
	if([port_e high]) {
		[part_e setHigh:YES];
	}
	else {
		[part_e setHigh:NO];
	}
	
	//part_f
	port* port_f = [ports objectAtIndex:1];
	displayPart* part_f = [displayParts objectAtIndex:5];	
	if([port_f high]) {
		[part_f setHigh:YES];
	}
	else {
		[part_f setHigh:NO];
	}
	
	//part_g
	port* port_g = [ports objectAtIndex:10];
	displayPart* part_g = [displayParts objectAtIndex:6];	
	if([port_g high]) {
		[part_g setHigh:YES];
	}
	else {
		[part_g setHigh:NO];
	}
		
	//part_g
	port* port_DP = [ports objectAtIndex:8];
	displayPart* part_DP = [displayParts objectAtIndex:7];	
	if([port_DP high]) {
		[part_DP setHigh:YES];
	}
	else {
		[part_DP setHigh:NO];
	}
	}
}

-(void)loadDisplayParts {
	displayParts = [[NSMutableArray alloc] init];
	
	displayPart* part_a = [[displayPart alloc] initAtPos:NSMakePoint(32,71) position:3 ];
	[displayParts addObject:part_a];
	
	displayPart* part_b = [[displayPart alloc] initAtPos:NSMakePoint(74,73) position:2 ];
	[displayParts addObject:part_b];
	
	displayPart* part_c = [[displayPart alloc] initAtPos:NSMakePoint(74,127) position:7 ];
	[displayParts addObject:part_c];
	
	displayPart* part_d = [[displayPart alloc] initAtPos:NSMakePoint(32, 169) position:4 ];
	[displayParts addObject:part_d];
	
	displayPart* part_e = [[displayPart alloc] initAtPos:NSMakePoint(30,127) position:6 ];
	[displayParts addObject:part_e];
	
	displayPart* part_f = [[displayPart alloc] initAtPos:NSMakePoint(30,73) position:1 ];
	[displayParts addObject:part_f];
	
	displayPart* part_g = [[displayPart alloc] initAtPos:NSMakePoint(32,125) position:5 ];
	[displayParts addObject:part_g];
	
	displayPart* part_DP = [[displayPart alloc] initAtPos:NSMakePoint(76, 169) position:8 ];
	[displayParts addObject:part_DP];
}

-(NSString*)name {
	return @"5082-7651";
}

- (NSArray*)displayParts {
	return displayParts;
}

@end
