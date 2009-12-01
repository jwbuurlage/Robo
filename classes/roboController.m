//
//  roboController.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 08-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "roboController.h"


@implementation roboController


-(id)init {
	self = [super init];
	if(self) {
		[tableView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleSourceList];
		[self startRepeatingTimer];
		[self _re_initializeArray];
	}
	return self;
}


- (void)awakeFromNib
{
	roboCell * aCustomCell = [[[roboCell alloc] init] autorelease];
	[[tableView tableColumnWithIdentifier:@"theTableColumn"] setDataCell:aCustomCell];
}

-(NSArray*)ICArray {
	return [NSArray arrayWithArray:icArray];
}

-(void)_re_initializeArray {
	if(icArray) {
		[icArray dealloc];
	}
	icArray = [[NSMutableArray alloc] init];
	
	voltage* newVoltage = [[voltage alloc] initAtPosition:NSMakePoint(20,20)];
	[icArray addObject:newVoltage];
	
	pulsenGenerator* newPulse = [[pulsenGenerator alloc] initAtPosition:NSMakePoint(20,20) document:document];
	[icArray addObject:newPulse];
	
	LED* newLED = [[LED alloc] initAtPosition:NSMakePoint(20,20)];
	[icArray addObject:newLED];
	
	SN7400* newSN7400 = [[SN7400 alloc] initAtPosition:NSMakePoint(20, 20)];
	[icArray addObject:newSN7400];
	
	SN74247* newSN74247 = [[SN74247 alloc] initAtPosition:NSMakePoint(20, 20)];
	[icArray addObject:newSN74247];
	
	SN7490* newSN7490 = [[SN7490 alloc] initAtPosition:NSMakePoint(20, 20)];
	[icArray addObject:newSN7490];	
	
	D_5082_7651* display = [[D_5082_7651 alloc] initAtPosition:NSMakePoint(20, 20)];
	[icArray addObject:display];
	
	schakelaar* newSchakelaar = [[schakelaar alloc] initAtPosition:NSMakePoint(20,20)];
	[icArray addObject:newSchakelaar];
	
	invertor* newInvertor = [[invertor alloc] initAtPosition:NSMakePoint(20,20)];
	[icArray addObject:newInvertor];
	
	OR* newOR = [[OR alloc] initAtPosition:NSMakePoint(20, 20)];
	[icArray addObject:newOR];
	
	EN* newEN = [[EN alloc] initAtPosition:NSMakePoint(20, 20)];
	[icArray addObject:newEN];
	
	NEN* newNEN = [[NEN alloc] initAtPosition:NSMakePoint(20, 20)];
	[icArray addObject:newNEN];
	
	XOR* newXOR = [[XOR alloc] initAtPosition:NSMakePoint(20, 20)];
	[icArray addObject:newXOR];
	
	NOR* newNOR = [[NOR alloc] initAtPosition:NSMakePoint(20,20)];
	[icArray addObject:newNOR];	
	
	coincidentie* newCOIN = [[coincidentie alloc] initAtPosition:NSMakePoint(20,20)];
	[icArray addObject:newCOIN];	
}

-(IBAction)addIC:(id)sender {
	unsigned int rowIndex;
	rowIndex = [tableView selectedRow];
	
	if((rowIndex < 0) || (rowIndex >= [icArray count])) { return; }
	if(rowIndex == 0) {

	}
	[document addObjectToICArray:[icArray objectAtIndex:rowIndex]];
	[document updateAllPorts];
	[document setActiveView];
	[self _re_initializeArray];
}

-(int)numberOfRowsInTableView:(NSTableView*)aTableView { return [icArray count]; }
-(id)tableView:(NSTableView*)aTableView objectValueForTableColumn:(NSTableColumn*)aTableColumn row:(int)rowIndex { 
	return [[icArray objectAtIndex:rowIndex] name];
}

- (void)startRepeatingTimer {
    pulseInterval = [NSTimer scheduledTimerWithTimeInterval:0.5
													 target:self selector:@selector(timerFireMethod:)
												   userInfo:[self userInfo] repeats:YES];
}

- (void)timerFireMethod:(NSTimer*)theTimer {
	for(id thePulse in [document ICs]) {
		if([thePulse isPulse]) {
			if(setHigh) { [[[thePulse ports] objectAtIndex:0] setHigh:NO]; }
			else { [[[thePulse ports] objectAtIndex:0] setHigh:YES]; }
			[document updateAllPorts];
		}
	}
	if(setHigh) { setHigh = FALSE; } else { setHigh = TRUE; }
}

- (NSDictionary *)userInfo {
	return [NSDictionary dictionaryWithObject:[NSDate date] forKey:@"StartDate"];
}

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	[aCell setTarget:self];
	[aCell setAction:@selector(addIC:)];
	[aCell setSubTitle:[[icArray objectAtIndex:rowIndex] description]];
	[aCell setImage:[[icArray objectAtIndex:rowIndex] image]];
}
	

@end
