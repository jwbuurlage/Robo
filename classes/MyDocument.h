//
//  MyDocument.h
//  Robo
//



#import <Cocoa/Cocoa.h>
#import "roboView.h"
#import "connection.h"

//ICs
#import "SN7400.h"
#import "SN7490.h"
#import "SN74247.h"
#import "D5082-7651.h"

//Simpele Clusters
#import "OR.h"
#import "NEN.h"
#import "LED.h"
#import "EN.h"
#import "XOR.h"
#import "voltage.h"
#import "invertor.h"
#import "pulsenGenerator.h"

@class roboView;

@interface MyDocument : NSDocument
{
	NSMutableArray* ConnectionsArray;
	NSMutableArray* ICSArray;
	IBOutlet roboView* view;
}

- (NSArray*)ICs;
- (NSArray*)connections;

-(void)updateAllPorts;
-(void)addObjectToConnections:(id)theObject;
-(void)addObjectToICArray:(id)theObject;
-(void)removeConnection:(connection*)theObject;
-(void)removeIC:(id)theObject;

-(void)setActiveView;

-(void)connectIC:(id)firstIC to:(id)secondIC;

@end
