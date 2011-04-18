//
//  SXMotionTween Example
//
//  Created by Bruno Abrantes Basseto on 15/04/11.
//  bruno.basseto@uol.com.br

#import "MyStage.h"

@implementation MyStage

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height])
    { 
		// --------------
		// our ship image
		// --------------
		SPImage *img = [SPImage imageWithContentsOfFile: @"ship.png"];

		// ------------------------------------------------
		// place it in the center of a sprite, for rotation
		// ------------------------------------------------
		SPSprite *sp = [SPSprite sprite];
		img.x = -16;
		img.y = -16;
		[sp addChild: img];
		[self addChild: sp];

		// ----------------------
		// create the motion path
		// ----------------------
		SXMotionTweenPath *path = [SXMotionTweenPath path];
		[path startPoint: [SPPoint pointWithX: -32 y: 200]];
		[path addLineToPoint: [SPPoint pointWithX: 150 y: 200] duration: 1.0];
		[path addCurveToPoint: [SPPoint pointWithX: 100 y: 300] 
				controlPoints: [SPPoint pointWithX: 350 y: 200] 
						  and: [SPPoint pointWithX: 100 y: 50] 
					 duration: 1.0];
		[path addArcToPoint: [SPPoint pointWithX: 350 y: 480] 
				  withFocus: [SPPoint pointWithX: 200 y: 480] 
				   duration: 1.0];
		
		// -----------------------
		// create the motion tween
		// -----------------------
		SXMotionTween *tween = [SXMotionTween tweenWithTarget: sp andPath: path];
		tween.delay = 1;					// wait one second
		tween.adjustAngle = YES;			// make the image rotate along the path
		tween.angleOffset = 3.14/2;			// adjust facing position
		[tween addEventListener: @selector(animOk:) 
					   atObject: self forType: SP_EVENT_TYPE_TWEEN_COMPLETED];
		[self.stage.juggler addObject: tween];
		
    }
    return self;
}

-(void)animOk: (SPEvent *)e
{
	NSLog(@"Animation done!");
}

@end
