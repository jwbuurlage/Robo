//
//  OR.h
//  Robo
//


#import <Cocoa/Cocoa.h>
#import "roboObject.h"

@interface OR : roboObject {

}

-(id)initAtPosition:(NSPoint)positionInView;
-(void)updateAllPorts;
-(NSString*)name;

@end
