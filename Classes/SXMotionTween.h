// -----------------------------------------------
//  SXMotionTween.h
//  Sparrow Framework
//  SXMotionTween Extension
//
//  Created by Bruno Abrantes Basseto on 15/04/11.
//  bruno.basseto@uol.com.br
// -----------------------------------------------

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "SXMotionTweenPath.h"

@interface SXMotionTween : SPEventDispatcher <SPAnimatable> {
	SXMotionTweenPath *path;
	SPDisplayObject *target;
	
	int currentSegment;
	double currentTime;

	BOOL isComplete;
	BOOL adjustAngle;
	BOOL started;
	BOOL loop;
	double delay;
	double angleOffset;
	float offsetX;
	float offsetY;
}

@property (nonatomic, readonly) BOOL isComplete;
@property (nonatomic, readonly) SPDisplayObject *target;
@property (nonatomic, retain) SXMotionTweenPath *path;
@property (nonatomic, assign) BOOL adjustAngle;
@property (nonatomic, assign) double angleOffset;
@property (nonatomic, assign) float offsetX;
@property (nonatomic, assign) float offsetY;
@property (nonatomic, assign) double delay;
@property (nonatomic, assign) BOOL loop;

+(id)tweenWithTarget: (SPDisplayObject *)aTarget;
+(id)tweenWithTarget: (SPDisplayObject *)aTarget andPath: (SXMotionTweenPath *)aPath;
-(void)advanceTime: (double)seconds;
-(void)dealloc;

@end
