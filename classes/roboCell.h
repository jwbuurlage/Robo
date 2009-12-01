//
//  roboCell.h
//  Robo
//
//  Created by Jan-Willem Buurlage on 09-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface roboCell : NSActionCell {
	NSString* subTitle;
	NSImage* image;
}
@property (retain)NSString* subTitle;
@property (retain)NSImage* image;

@end
