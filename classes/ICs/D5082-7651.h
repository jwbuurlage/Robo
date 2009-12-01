//
//  5082-7651.h
//  Robo
//
//  Created by Jan-Willem Buurlage on 08-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IC.h"
#import "displayPart.h"

@interface D_5082_7651 : IC {
	NSMutableArray* displayParts;
}

-(id)initAtPosition:(NSPoint)positionInView;
-(void)updateAllPorts;
-(void)loadDisplayParts;
-(NSString*)name;

@end
