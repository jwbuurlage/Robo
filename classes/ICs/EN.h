//
//  OR.h
//  Robo
//


#import <Cocoa/Cocoa.h>
#import "roboObject.h"

@interface EN : roboObject {
	
}

-(id)initAtPosition:(NSPoint)positionInView;
-(void)updateAllPorts;
-(NSString*)name;

@end
