// -----------------------------------------------
//  SXMotionTween.m
//  Sparrow Framework
//  SXMotionTween Extension
//
//  Created by Bruno Abrantes Basseto on 15/04/11.
//  bruno.basseto@uol.com.br
// -----------------------------------------------

#import "SXMotionTween.h"

@implementation SXMotionTween
@synthesize isComplete;
@synthesize delay, loop;
@synthesize target, path;
@synthesize adjustAngle, angleOffset;
@synthesize offsetX, offsetY;

#pragma mark -
#pragma mark Initialization and Release
+(id)tweenWithTarget: (SPDisplayObject *)aTarget
{
	return [SXMotionTween tweenWithTarget: aTarget andPath: nil];
}

+(id)tweenWithTarget: (SPDisplayObject *)aTarget andPath: (SXMotionTweenPath *)aPath
{
	SXMotionTween *s = [[[SXMotionTween alloc] init] autorelease];
	if(!s) return nil;
	
	s->target = aTarget;
	s->isComplete = NO;
	s->started = NO;
	s->currentTime = 0;
	s->currentSegment = 0;
	s->path = [aPath retain];
	s->adjustAngle = NO;
	s->loop = NO;
	s->delay = 0;
	s->offsetX = 0;
	s->offsetY = 0;
	return s;
}

-(void)dealloc
{
	[path release];
	[super dealloc];
}

#pragma mark -
#pragma mark Tween Update
-(void)advanceTime: (double)seconds
{
	// ---------------------------
	// verify animation completion
	// ---------------------------
	if(isComplete) return;

	// -----------------------
	// update time information
	// -----------------------
	currentTime += seconds;
	
	// ---------------------------------------
	// check for initialization and delay time
	// ---------------------------------------
	if(!started) {
		// -------------------
		// wait for delay time
		// -------------------
		if(currentTime < delay) return;
		
		// ------------------------------
		// start animation and fire event
		// ------------------------------
		currentTime = 0;
		started = YES;
		if ([self hasEventListenerForType:SP_EVENT_TYPE_TWEEN_STARTED]) {
			SPEvent *event = [[SPEvent alloc] initWithType: SP_EVENT_TYPE_TWEEN_STARTED];
			[self dispatchEvent: event];
			[event release];
		}
	} else {
		// -----------------
		// fire update event
		// -----------------
		if ([self hasEventListenerForType:SP_EVENT_TYPE_TWEEN_UPDATED]) {
			SPEvent *event = [[SPEvent alloc] initWithType: SP_EVENT_TYPE_TWEEN_UPDATED];
			[self dispatchEvent: event];
			[event release];
		}
	}
	
	// ----------------------------------
	// find path segment for current time
	// ----------------------------------
	SXMotionTweenPathSegment *seg = [path segmentAtIndex: currentSegment];
	while(currentTime > seg.duration) {
		currentTime -= seg.duration;
		currentSegment++;
		if(currentSegment == [path count]) {
			// -----------------
			// last segment done
			// -----------------
			if(loop) {
				currentSegment = 0;
				return;
			} else {
				// --------------------
				// fire completed event
				// --------------------
				isComplete = YES;
				if ([self hasEventListenerForType:SP_EVENT_TYPE_TWEEN_COMPLETED]) {
					SPEvent *event = [[SPEvent alloc] initWithType: SP_EVENT_TYPE_TWEEN_COMPLETED];
					[self dispatchEvent: event];
					[event release];
				}
				return;
			}
		} else seg = [path segmentAtIndex: currentSegment];
	}
	
	// ------------------------------------
	// find position inside current segment
	// ------------------------------------
	SPPoint *pos = [seg positionWhen: currentTime];
	target.x = offsetX + pos.x;
	target.y = offsetY + pos.y;
	if(adjustAngle) target.rotation = angleOffset + seg.angle;
}

@end
