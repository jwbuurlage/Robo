//
//  LED.h
//  Robo
//
//  Created by Thijs Scheepers on 10-01-09.
//  Copyright 2009 Web6.nl Diensten. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "roboObject.h"

@interface LED : roboObject {
	NSMutableArray* displayParts;
}

-(id)initAtPosition:(NSPoint)positionInView;
-(void)updateAllPorts;
-(NSString*)name;
-(NSArray*)displayParts;

@end

