//
//  port.h
//  Robo
//


#import <Cocoa/Cocoa.h>


@interface port : NSObject {
	NSMutableString* label;
	int number;
	BOOL high;
	BOOL input;
	NSPoint relPos;
	BOOL specialInput;
	id ofObject;
}
@property (retain)NSMutableString* label;
@property int number;
@property BOOL high;
@property BOOL specialInput;
@property BOOL input;
@property NSPoint relPos;
@property (retain)id ofObject;

- (id)initWithLabel:(NSMutableString*)label 
			 number:(int)number
			   high:(BOOL)high
			  input:(BOOL)input
			  point:(NSPoint)relPos
		  forObject:(id)anObject;

@end
