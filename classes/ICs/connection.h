//
//  connection.h
//  Robo
//


#import <Cocoa/Cocoa.h>
#import "port.h"

@interface connection : NSObject {
	port* input;
	port* output;
}
@property (retain)port* input;
@property (retain)port* output;

-(id)initWithOutput:(port*)output;
-(void)closeWithInput:(port*)input;

@end
