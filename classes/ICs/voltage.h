//
//  voltage.h
//  Robo
//
//  Created by Jan-Willem Buurlage on 07-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "roboObject.h"

@interface voltage : roboObject {
	
}

-(id)initAtPosition:(NSPoint)positionInView;
-(void)updateAllPorts;
-(NSString*)name;

@end
