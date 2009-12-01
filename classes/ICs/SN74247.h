//
//  SN74247.h
//  Robo
//
//  Created by Jan-Willem Buurlage on 07-01-09.
//  Copyright 2009 Mote of Life. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IC.h"

@interface SN74247 : IC {
	//SN74247 is een decoder
}

-(id)initAtPosition:(NSPoint)positionInView;
-(void)updateAllPorts;
-(NSString*)name;

@end