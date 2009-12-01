//
//  OR.m
//  Robo
//


#import "EN.h"


@implementation EN

-(id)initAtPosition:(NSPoint)positionInView {
	self = [super init];
	if(self) {
		//init van alle poorten, in de array stoppen
		int portNumber = 1;
		
		//port 1
		port* port01 = [[port alloc] initWithLabel: @""
											number: 1
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(-10, 5) 
										 forObject: self ];
		[ports addObject:port01];
		++portNumber;
		
		port* port02 = [[port alloc] initWithLabel: @""
											number: 2
											  high: FALSE
											 input: TRUE 
											 point: NSMakePoint(-10, 30) 
										 forObject: self ];
		[ports addObject:port02];
		++portNumber;
		
		port* port03 = [[port alloc] initWithLabel: @""
											number: 3
											  high: FALSE
											 input: FALSE 
											 point: NSMakePoint(70, 17.5) 
										 forObject: self ];
		[ports addObject:port03];
		++portNumber;
		
		
		[self setSize:NSMakeSize(80,55)];
		[self setLabel:@"EN"];
		[self setDescription:@"Een EN-poort"];
		[self setPosInView:positionInView];
	}
	
	return self;
}

-(void)updateAllPorts {
	id port01 = [ports objectAtIndex:0];
	id port02 = [ports objectAtIndex:1];
	id port03 = [ports objectAtIndex:2];
	
	if([port01 high] && [port02 high]) {
	[port03 setHigh:TRUE]; 
	}
	else {
		[port03 setHigh:FALSE];
	}
}

-(NSString*)name {
	return @"EN-Poort";
}

@end
