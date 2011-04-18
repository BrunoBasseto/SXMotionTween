//
//  tweenXAppDelegate.m
//  tweenX
//
//  Created by Bruno Abrantes Basseto on 15/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "tweenXAppDelegate.h"

@implementation tweenXAppDelegate

@synthesize window;
@synthesize gameView;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    SP_CREATE_POOL(pool);    
	
    [SPStage setSupportHighResolutions:YES];
    [SPAudioEngine start];
	
    MyStage *myStage = [[MyStage alloc] init];        
    gameView.stage = myStage;
    [myStage release];
	
    [window makeKeyAndVisible];
    [gameView start];
	
    SP_RELEASE_POOL(pool);    
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [gameView stop];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [gameView stop];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [gameView start];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [gameView start];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
	[gameView release];
    [super dealloc];
}


@end
