//
//  SN7400.h
//  Robo
//



#import <Cocoa/Cocoa.h>
#import "IC.h"

@interface SN7400 : IC {
	//SN7400 is een IC met 4 NEN poorten, het heeft 14 ports
}

-(id)initAtPosition:(NSPoint)positionInView;
-(void)updateAllPorts;
-(NSString*)name;

@end
