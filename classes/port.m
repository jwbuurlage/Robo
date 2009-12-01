//
//  port.m
//  Robo
//


#import "port.h"


@implementation port

@synthesize label, number, high, input, relPos, ofObject, specialInput;

- (id)initWithLabel:(NSMutableString*)initLabel 
			 number:(int)initNumber
			   high:(BOOL)initHigh
			  input:(BOOL)initInput 
			  point:(NSPoint)initRelPos 
		  forObject:(id)anObject {
	
	self = [super init];
	
	if(self) {
		[self setLabel:initLabel];
		[self setNumber:initNumber];
		[self setHigh:initHigh];
		[self setInput:initInput];
		[self setRelPos:initRelPos];
		[self setOfObject:anObject];
	}
	
	return self;	
}

#pragma mark enable saving and loading
-(void)encodeWithCoder:(NSCoder *)coder {		//save to file
	[coder encodeObject:label forKey:@"P_label"];
	[coder encodeInt:number forKey:@"P_number"];
	[coder encodeBool:high forKey:@"P_high"];
	[coder encodeBool:input forKey:@"P_input"];
	[coder encodePoint:relPos forKey:@"P_relPos"];
	[coder encodeObject:ofObject forKey:@"P_ofObject"];
}
-(id)initWithCoder:(NSCoder *)coder {			//unarchive from file
	[super init];
	label = [[coder decodeObjectForKey:@"P_label"] retain];
	number = [coder decodeIntForKey:@"P_number"];
	high = [coder decodeBoolForKey:@"P_high"];
	input = [coder decodeBoolForKey:@"P_input"];	
	relPos = [coder decodePointForKey:@"P_relPos"];
	ofObject = [[coder decodeObjectForKey:@"P_ofObject"] retain];	
	return self;
}

@end
