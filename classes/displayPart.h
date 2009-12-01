//
//  displayPart.h
//  Robo
//
//  Created by Jan-Willem Buurlage on 08-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface displayPart : NSObject <NSCoding> {
	BOOL high;
	int position;
		//position:
		//1: LEFT
		//2: RIGHT
		//3: TOP
		//4: BOTTOM
		//5: MIDDLE
		//6: BOTTOM-LEFT
		//7: BOTTOM-RIGHT
		//8: DOT
		//9: LED-Display
	NSPoint relPos;
}

@property int position;
@property BOOL high;
@property NSPoint relPos;

-(id)initAtPos:(NSPoint)pos position:(int)pos;

@end
