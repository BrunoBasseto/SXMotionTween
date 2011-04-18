//
//  tweenXAppDelegate.h
//  tweenX
//
//  Created by Bruno Abrantes Basseto on 15/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sparrow.h"
#import "MyStage.h"

@interface tweenXAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	SPView *gameView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SPView *gameView;

@end

