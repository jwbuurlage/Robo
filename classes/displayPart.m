//
//  displayPart.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 08-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "displayPart.h"


@implementation displayPart

@synthesize high, relPos, position;

-(id)initAtPos:(NSPoint)pos position:(int)type {
	self = [super init];
	if(self) {
		[self setHigh:FALSE];
		[self setRelPos:pos];
		[self setPosition:type];
	}
	return self;
}

#pragma mark enable saving and loading
-(void)encodeWithCoder:(NSCoder *)coder {		//save to file
	[coder encodeInt:position forKey:@"d_position"];
	[coder encodePoint:relPos forKey:@"d_relPos"];	
	[coder encodeBool:high forKey:@"d_high"];		
}
-(id)initWithCoder:(NSCoder *)coder {			//unarchive from file
	[super init];
	position = [coder decodeIntForKey:@"d_position"];
	relPos = [coder decodePointForKey:@"d_relPos"];	
	high = [coder decodeBoolForKey:@"d_high"];	
	return self;
}

@end
