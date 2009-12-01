#import "SN7400.h"


@implementation SN7400

-(id)initAtPosition:(NSPoint)positionInView {
	self = [super init];
	if(self) {
		//init van alle poorten, in de array stoppen
		int portNumber = 1;
		
		//port 1
		port* port01 = [[port alloc] initWithLabel: @"IN"
											number: 1
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		[ports addObject:port01];
		++portNumber;
		
		//port 2
		port* port02 = [[port alloc] initWithLabel: @"IN"
											number: 2
											  high: FALSE
											 input: TRUE
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		[ports addObject:port02];
		++portNumber;
		
		//port 3		
		port* port03 = [[port alloc] initWithLabel: @"UIT"
											number: 3
											  high: TRUE
											 input: FALSE
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		[ports addObject:port03];
		++portNumber;
		
		//port 4		
		port* port04 = [[port alloc] initWithLabel: @"IN"
											number: 4
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port04];
		++portNumber;
		
		//port 5		
		port* port05 = [[port alloc] initWithLabel: @"IN"
											number: 5
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port05];		
		++portNumber;
		
		//port 6		
		port* port06 = [[port alloc] initWithLabel: @"UIT"
											number: 6
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port06];
		++portNumber;
		
		//port 7		
		port* port07 = [[port alloc] initWithLabel: @"GND"
											number: 7
											  high: FALSE
											 input: FALSE 
											 point: NSMakePoint((portNumber * 30), 90) 
										 forObject: self ];
		
		[ports addObject:port07];
		++portNumber;
		
		//port 8		
		port* port08 = [[port alloc] initWithLabel: @"UIT"
											number: 8
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port08];
		++portNumber;
		
		//port 9		
		port* port09 = [[port alloc] initWithLabel: @"IN"
											number: 9
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port09];
		++portNumber;
		
		//port 10		
		port* port10 = [[port alloc] initWithLabel: @"IN"
											number: 10
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port10];
		++portNumber;
		
		//port 11		
		port* port11 = [[port alloc] initWithLabel: @"UIT"
											number: 11
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port11];
		++portNumber;
		
		//port 12		
		port* port12 = [[port alloc] initWithLabel: @"IN"
											number: 12
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port12];
		++portNumber;
		
		//port 13		
		port* port13 = [[port alloc] initWithLabel: @"IN"
											number: 13
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint((210 + (8 - portNumber) * 30), -10) 
										 forObject: self ];
		
		[ports addObject:port13];
		++portNumber;
		
		//port 14		
		port* port14 = [[port alloc] initWithLabel: @"5V"
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
		[self setLabel:@"SN7400"];
		[self setDescription:@"IC met 4 NEN poorten"];

	}
	return self;
}

-(void)updateAllPorts {
	/* SN7400 zijn 4 NEN poorten
	 *
	 * -| 1 + 2 = 3 (NEN)
	 * -| 4 + 5 = 6 (NEN)
	 * -| 7 = aarden
	 * -| 8 + 9 = 10 (NEN)
	 * -| 11 + 12 = 13 (NEN)
	 * -| 14 = spanning
	 *
	 */
	//we hebben 5V nodig
	port* highPort = [ports objectAtIndex:13];
	if([highPort high] == FALSE) {
		for(port* output in ports) {
			if(![output input]) {
				[output setHigh:NO];
			}
		}
	}
	else {
	//kijken of port 3 hoog of laag is
	id port01 = [ports objectAtIndex:0];
	id port02 = [ports objectAtIndex:1];
	id port03 = [ports objectAtIndex:2];
	
	if([port01 high] && [port02 high]) {
		[port03 setHigh:FALSE];
	}
	else {
		[port03 setHigh:TRUE];
	}
	
	//kijken of port 6 hoog of laag is
	id port04 = [ports objectAtIndex:3];
	id port05 = [ports objectAtIndex:4];
	id port06 = [ports objectAtIndex:5];
	
	if([port04 high] && [port05 high]) {
		[port06 setHigh:FALSE];
	}
	else {
		[port06 setHigh:TRUE];
	}
	
	//kijken of port 8 hoog of laag is
	id port08 = [ports objectAtIndex:7];
	id port09 = [ports objectAtIndex:8];
	id port10 = [ports objectAtIndex:9];
	
	if([port09 high] && [port10 high]) {
		[port08 setHigh:FALSE];
	}
	else {
		[port08 setHigh:TRUE];
	}
	
	//kijken of port 11 hoog of laag is
	id port11 = [ports objectAtIndex:10];
	id port12 = [ports objectAtIndex:11];
	id port13 = [ports objectAtIndex:12];
	
	if([port12 high] && [port13 high]) {
		[port11 setHigh:FALSE];
	}
	else {
		[port11 setHigh:TRUE];
	}
	}
}

-(NSString*)name {
	return @"SN7400";
}

@end
