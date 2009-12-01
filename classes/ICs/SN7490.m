//
//  SN7490.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 08-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SN7490.h"


@implementation SN7490

-(id)initAtPosition:(NSPoint)positionInView {
	self = [super init];
	if(self) {
		//init van alle poorten, in de array stoppen
		int portNumber = 1;
		
		//port 1
		port* port01 = [[port alloc] initWithLabel: @"CLK(2)"
											number: 1
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		[ports addObject:port01];
		++portNumber;
		
		//port 2
		port* port02 = [[port alloc] initWithLabel: @"R1"
											number: 2
											  high: FALSE
											 input: TRUE
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		[ports addObject:port02];
		++portNumber;
		
		//port 3		
		port* port03 = [[port alloc] initWithLabel: @"R2"
											number: 3
											  high: TRUE
											 input: FALSE
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		[ports addObject:port03];
		++portNumber;
		
		//port 4		
		port* port04 = [[port alloc] initWithLabel: @"NC"
											number: 4
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port04];
		++portNumber;
		
		//port 5		
		port* port05 = [[port alloc] initWithLabel: @"5V"
											number: 5
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port05];		
		++portNumber;
		
		//port 6		
		port* port06 = [[port alloc] initWithLabel: @"R3"
											number: 6
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port06];
		++portNumber;
		
		//port 7		
		port* port07 = [[port alloc] initWithLabel: @"R4"
											number: 7
											  high: FALSE
											 input: FALSE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port07];
		++portNumber;
		
		//port 8		
		port* port08 = [[port alloc] initWithLabel: @"C"
											number: 8
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port08];
		++portNumber;
		
		//port 9		
		port* port09 = [[port alloc] initWithLabel: @"B"
											number: 9
											  high: FALSE
											 input: FALSE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port09];
		++portNumber;
		
		//port 10		
		port* port10 = [[port alloc] initWithLabel: @"GRD"
											number: 10
											  high: FALSE
											 input: FALSE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port10];
		++portNumber;
		
		//port 11		
		port* port11 = [[port alloc] initWithLabel: @"D"
											number: 11
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port11];
		++portNumber;
		
		//port 12		
		port* port12 = [[port alloc] initWithLabel: @"A"
											number: 12
											  high: FALSE
											 input: FALSE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port12];
		++portNumber;
		
		//port 13		
		port* port13 = [[port alloc] initWithLabel: @"NC"
											number: 13
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port13];
		++portNumber;
		
		//port 14		
		port* port14 = [[port alloc] initWithLabel: @"CLK(1)"
											number: 14
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port14];
		
		
		/* NSString* backgroundFile = @"/SN7400_bg.png";		
		 NSImage* background = [[NSImage alloc] initWithContentsOfFile:backgroundFile];
		 [self setBackgroundImage:background]; */
		//positie geven
		[self setSize:NSMakeSize((7 * 30) + 40, 100)];
		[self setPosInView:positionInView];
		[self setLabel:@"SN7490"];
		[self setDescription:@"Een eenvoudige teller"];
		count = 0;
	}
	return self;
}

-(void)updateAllPorts {
	//we hebben 5V nodig
	port* highPort = [ports objectAtIndex:4];
	if([highPort high] == FALSE) {
		for(port* output in ports) {
			if(![output input]) {
				[output setHigh:NO];
			}
		}
	}
	else {
		port* clockPort = [ports objectAtIndex:13];
		
		port* port_A = [ports objectAtIndex: 11];
		port* port_B = [ports objectAtIndex: 8];
		port* port_C = [ports objectAtIndex: 7];
		port* port_D = [ports objectAtIndex: 10];
		
		if([clockPort high]) {
			if(wasLow) {
				++count;
			}
			wasLow = FALSE;
		}
		else {
			wasLow = TRUE;
		}
		
		
		if(count > 9) {
			count = 0;
		}
		
		switch(count) {
			case 0: 
				[port_A setHigh:NO];
				[port_B setHigh:NO];
				[port_C setHigh:NO];
				[port_D setHigh:NO];
				break;
			case 1: 
				[port_A setHigh:YES];
				[port_B setHigh:NO];
				[port_C setHigh:NO];
				[port_D setHigh:NO];
				break;
			case 2: 
				[port_A setHigh:NO];
				[port_B setHigh:YES];
				[port_C setHigh:NO];
				[port_D setHigh:NO];
				break;
			case 3: 
				[port_A setHigh:YES];
				[port_B setHigh:YES];
				[port_C setHigh:NO];
				[port_D setHigh:NO];
				break;
			case 4: 
				[port_A setHigh:NO];
				[port_B setHigh:NO];
				[port_C setHigh:YES];
				[port_D setHigh:NO];
				break;
			case 5: 
				[port_A setHigh:YES];
				[port_B setHigh:NO];
				[port_C setHigh:YES];
				[port_D setHigh:NO];
				break;
			case 6: 
				[port_A setHigh:NO];
				[port_B setHigh:YES];
				[port_C setHigh:YES];
				[port_D setHigh:NO];
				break;
			case 7: 
				[port_A setHigh:YES];
				[port_B setHigh:YES];
				[port_C setHigh:YES];
				[port_D setHigh:NO];
				break;
			case 8: 
				[port_A setHigh:NO];
				[port_B setHigh:NO];
				[port_C setHigh:NO];
				[port_D setHigh:YES];
				break;
			case 9: 
				[port_A setHigh:YES];
				[port_B setHigh:NO];
				[port_C setHigh:NO];
				[port_D setHigh:YES];
				break;
		}
	}
}

-(NSString*)name {
	return @"SN7490";
}


@end
