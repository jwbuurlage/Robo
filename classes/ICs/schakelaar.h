//
//  schakelaar.h
//  Robo
//
//  Created by Jan-Willem Buurlage on 11-01-09.
//  Copyright 2009 Mote of Life. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "roboObject.h"

@interface schakelaar : roboObject {

}

-(id)initAtPosition:(NSPoint)positionInView;
-(void)updateAllPorts;
-(NSString*)name;

@end
