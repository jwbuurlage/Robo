//
//  SN7490.h
//  Robo
//
//  Created by Jan-Willem Buurlage on 08-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IC.h"

@interface SN7490 : IC {
	//SN7490 is een teller, het heeft 14 ports
	int count;
	BOOL wasLow;
}

-(id)initAtPosition:(NSPoint)positionInView;
-(void)updateAllPorts;
-(NSString*)name;

@end
