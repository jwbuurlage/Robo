//
//  pulsenGenerator.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 08-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "pulsenGenerator.h"


@implementation pulsenGenerator

-(id)initAtPosition:(NSPoint)positionInView document:(MyDocument*)theDocument {
	self = [super init];
	if(self) {
		//init van alle poorten, in de array stoppen
		port* port01 = [[port alloc] initWithLabel: @""
											number: 1
											  high: TRUE
											 input: FALSE 
											 point: NSMakePoint(60, 5) 
										 forObject: self ];
		[ports addObject:port01];
		
		document = theDocument;
		[self setSize:NSMakeSize(70,30)];
		[self setLabel:@"PULS"];
		[self setPosInView:positionInView];
		[self setIsPulse:TRUE];
		[self setDescription:@"Genereert pulsen met 1Hz"];
		image = [NSImage imageNamed:@"spoort"];
	}
	return self;
}

- (void)updateAllPorts {

}

- (NSDictionary *)userInfo {
    return [NSDictionary dictionaryWithObject:[NSDate date] forKey:@"StartDate"];
}

-(NSString*)name {
	return @"Pulsen";
}

@end
