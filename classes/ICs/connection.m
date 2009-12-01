//
//  connection.m
//  Robo
//


#import "connection.h"


@implementation connection

@synthesize input, output;

-(id)initWithOutput:(port*)theOutput {
	self = [super init];
	if(self) {
		[self setOutput:theOutput];
	}
	return self;
}

-(void)closeWithInput:(port*)theInput {
	[self setInput:theInput];
}

#pragma mark enable saving and loading
-(void)encodeWithCoder:(NSCoder *)coder {		//save to file
	[coder encodeObject:input forKey:@"C_input"];
	[coder encodeObject:output forKey:@"C_output"];	
}
-(id)initWithCoder:(NSCoder *)coder {			//unarchive from file
	[super init];
	input = [[coder decodeObjectForKey:@"C_input"] retain];
	output = [[coder decodeObjectForKey:@"C_output"] retain];	
	return self;
}

@end
