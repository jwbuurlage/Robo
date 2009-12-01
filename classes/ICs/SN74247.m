//
//  SN74247.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 07-01-09.
//  Copyright 2009 Mote of Life. All rights reserved.
//

#import "SN74247.h"


@implementation SN74247
-(id)initAtPosition:(NSPoint)positionInView {
	self = [super init];
	if(self) {
		//init van alle poorten, in de array stoppen
		int portNumber = 1;
		
		//port 1
		port* port01 = [[port alloc] initWithLabel: @"B"
											number: 1
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		[ports addObject:port01];
		++portNumber;
		
		//port 2
		port* port02 = [[port alloc] initWithLabel: @"C"
											number: 2
											  high: FALSE
											 input: TRUE
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		[ports addObject:port02];
		++portNumber;
		
		//port 3		
		port* port03 = [[port alloc] initWithLabel: @""
											number: 3
											  high: FALSE
											 input: TRUE
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		[ports addObject:port03];
		++portNumber;
		
		//port 4		
		port* port04 = [[port alloc] initWithLabel: @""
											number: 4
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port04];
		++portNumber;
		
		//port 5		
		port* port05 = [[port alloc] initWithLabel: @""
											number: 5
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port05];		
		++portNumber;
		
		//port 6		
		port* port06 = [[port alloc] initWithLabel: @"D"
											number: 6
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port06];
		++portNumber;
		
		//port 7		
		port* port07 = [[port alloc] initWithLabel: @"A"
											number: 7
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port07];
		++portNumber;
		
		//port 8		
		port* port08 = [[port alloc] initWithLabel: @"GND"
											number: 8
											  high: FALSE
											 input: FALSE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port08];
		++portNumber;
		
		//port 9		
		port* port09 = [[port alloc] initWithLabel: @"e"
											number: 9
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((240 + (9 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port09];
		++portNumber;
		
		//port 10		
		port* port10 = [[port alloc] initWithLabel: @"d"
											number: 10
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((240 + (9 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port10];
		++portNumber;
		
		//port 11		
		port* port11 = [[port alloc] initWithLabel: @"c"
											number: 11
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((240 + (9 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port11];
		++portNumber;
		
		//port 12		
		port* port12 = [[port alloc] initWithLabel: @"b"
											number: 12
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((240 + (9 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port12];
		++portNumber;
		
		//port 13		
		port* port13 = [[port alloc] initWithLabel: @"a"
											number: 13
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((240 + (9 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port13];
		++portNumber;
		
		//port 14		
		port* port14 = [[port alloc] initWithLabel: @"g"
											number: 14
											  high: FALSE
											 input: FALSE 
											 point: NSMakePoint((240 + (9 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port14];
		++portNumber;
		
		//port 15		
		port* port15 = [[port alloc] initWithLabel: @"f"
											number: 15
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((240 + (9 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port15];
		++portNumber;
		
		//port 16		
		port* port16 = [[port alloc] initWithLabel: @"5V"
											number: 16
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((240 + (9 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port16];
		
		/* NSString* backgroundFile = @"/SN7400_bg.png";		
		 NSImage* background = [[NSImage alloc] initWithContentsOfFile:backgroundFile];
		 [self setBackgroundImage:background]; */
		//positie geven
		[self setSize:NSMakeSize((8 * 30) + 40, 100)];
		[self setPosInView:positionInView];
		[self setLabel:@"SN74247"];
		[self setDescription:@"2-bits naar display; decoder"];
	}
	return self;
}

-(void)updateAllPorts {
	//we hebben 5V nodig
	port* highPort = [ports objectAtIndex:15];
	if([highPort high] == FALSE) {
		for(port* output in ports) {
			if(![output input]) {
				[output setHigh:NO];
			}
		}
	}
	else {
	// 2-BIT omzetten naar getal
	port* port_A = [ports objectAtIndex:6];
	port* port_B = [ports objectAtIndex:0];
	port* port_C = [ports objectAtIndex:1];
	port* port_D = [ports objectAtIndex:5];
	
	port* port_a = [ports objectAtIndex:12];
	port* port_b = [ports objectAtIndex:11];
	port* port_c = [ports objectAtIndex:10];
	port* port_d = [ports objectAtIndex:9];
	port* port_e = [ports objectAtIndex:8];
	port* port_f = [ports objectAtIndex:14];
	port* port_g = [ports objectAtIndex:13];
	
	int realValue = 0;
	if([port_A high]) { realValue += 1; }
	if([port_B high]) { realValue += 2; }
	if([port_C high]) { realValue += 4; }
	if([port_D high]) { realValue += 8; }
	
	switch(realValue) {
		case 0: 
			[port_a setHigh:YES];
			[port_b setHigh:YES];
			[port_c setHigh:YES];
			[port_d setHigh:YES];
			[port_e setHigh:YES];
			[port_f setHigh:YES];
			[port_g setHigh:NO];
			break;
		case 1:
			[port_a setHigh:NO];
			[port_b setHigh:YES];
			[port_c setHigh:YES];
			[port_d setHigh:NO];
			[port_e setHigh:NO];
			[port_f setHigh:NO];
			[port_g setHigh:NO];
			break;
		case 2:
			[port_a setHigh:YES];
			[port_b setHigh:YES];
			[port_c setHigh:NO];
			[port_d setHigh:YES];
			[port_e setHigh:YES];
			[port_f setHigh:NO];
			[port_g setHigh:YES];
			break;
		case 3:
			[port_a setHigh:YES];
			[port_b setHigh:YES];
			[port_c setHigh:YES];
			[port_d setHigh:YES];
			[port_e setHigh:NO];
			[port_f setHigh:NO];
			[port_g setHigh:YES];
			break;
		case 4:
			[port_a setHigh:NO];
			[port_b setHigh:YES];
			[port_c setHigh:YES];
			[port_d setHigh:NO];
			[port_e setHigh:NO];
			[port_f setHigh:YES];
			[port_g setHigh:YES];
			break;
		case 5: 
			[port_a setHigh:YES];
			[port_b setHigh:NO];
			[port_c setHigh:YES];
			[port_d setHigh:YES];
			[port_e setHigh:NO];
			[port_f setHigh:YES];
			[port_g setHigh:YES];
			break;
		case 6:
			[port_a setHigh:YES];
			[port_b setHigh:NO];
			[port_c setHigh:YES];
			[port_d setHigh:YES];
			[port_e setHigh:YES];
			[port_f setHigh:YES];
			[port_g setHigh:YES];
			break;
		case 7:
			[port_a setHigh:YES];
			[port_b setHigh:YES];
			[port_c setHigh:YES];
			[port_d setHigh:NO];
			[port_e setHigh:NO];
			[port_f setHigh:NO];
			[port_g setHigh:NO];
			break;
		case 8:
			[port_a setHigh:YES];
			[port_b setHigh:YES];
			[port_c setHigh:YES];
			[port_d setHigh:YES];
			[port_e setHigh:YES];
			[port_f setHigh:YES];
			[port_g setHigh:YES];
			break;
		case 9:
			[port_a setHigh:YES];
			[port_b setHigh:YES];
			[port_c setHigh:YES];
			[port_d setHigh:YES];
			[port_e setHigh:NO];
			[port_f setHigh:YES];
			[port_g setHigh:YES];
			break;
		case 10:
			[port_a setHigh:YES];
			[port_b setHigh:YES];
			[port_c setHigh:YES];
			[port_d setHigh:NO];
			[port_e setHigh:YES];
			[port_f setHigh:YES];
			[port_g setHigh:YES];
			break;
		case 11:
			[port_a setHigh:NO];
			[port_b setHigh:NO];
			[port_c setHigh:YES];
			[port_d setHigh:YES];
			[port_e setHigh:YES];
			[port_f setHigh:YES];
			[port_g setHigh:YES];
			break;
		case 12:
			[port_a setHigh:NO];
			[port_b setHigh:NO];
			[port_c setHigh:NO];
			[port_d setHigh:YES];
			[port_e setHigh:YES];
			[port_f setHigh:NO];
			[port_g setHigh:YES];
			break;
		case 13:
			[port_a setHigh:NO];
			[port_b setHigh:YES];
			[port_c setHigh:YES];
			[port_d setHigh:YES];
			[port_e setHigh:YES];
			[port_f setHigh:NO];
			[port_g setHigh:YES];
			break;
		case 14:
			[port_a setHigh:YES];
			[port_b setHigh:NO];
			[port_c setHigh:NO];
			[port_d setHigh:YES];
			[port_e setHigh:YES];
			[port_f setHigh:YES];
			[port_g setHigh:YES];
			break;
		case 15:
			[port_a setHigh:YES];
			[port_b setHigh:NO];
			[port_c setHigh:NO];
			[port_d setHigh:NO];
			[port_e setHigh:YES];
			[port_f setHigh:YES];
			[port_g setHigh:YES];
			break;
	}
	}
}

-(NSString*)name {
	return @"SN74247";
}

@end
