//
//  roboController.h
//  Robo
//
//  Created by Jan-Willem Buurlage on 08-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MyDocument.h"

//ICs
#import "SN7400.h"
#import "SN7490.h"
#import "D5082-7651.h"
#import "SN74247.h"

//Simpele Clusters
#import "OR.h"
#import "NOR.h"
#import "NEN.h"
#import "LED.h"
#import "schakelaar.h"
#import "EN.h"
#import "XOR.h"
#import "voltage.h"
#import "invertor.h"
#import "pulsenGenerator.h"
#import "coincidentie.h"

#import "roboCell.h"
#import "roboTable.h"

@interface roboController : NSObject {
	IBOutlet roboTable* tableView;
	NSMutableArray* icArray;
	IBOutlet MyDocument* document;

	BOOL setHigh;
	NSTimer* pulseInterval;
}

-(NSArray*)ICArray;

-(IBAction)addIC:(id)sender;

-(void)_re_initializeArray;

-(int)numberOfRowsInTableView:(NSTableView*)aTableView;
-(id)tableView:(NSTableView*)aTableView objectValueForTableColumn:(NSTableColumn*)aTableColumn row:(int)rowIndex;

-(void)startRepeatingTimer;
- (NSDictionary *)userInfo;

@end
