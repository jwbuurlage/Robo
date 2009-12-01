//
//  pulsenGenerator.h
//  Robo
//
//  Created by Jan-Willem Buurlage on 08-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "roboObject.h"
#import "MyDocument.h"

@class MyDocument;

@interface pulsenGenerator : roboObject {
	MyDocument* document;
	BOOL startedCounting;
}

-(void)updateAllPorts;
-(id)initAtPosition:(NSPoint)positionInView document:(MyDocument*)theDocument;

@end
