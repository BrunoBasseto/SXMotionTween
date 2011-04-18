// -----------------------------------------------
//  SXMotionTweenPathSegment.h
//  Sparrow Framework
//  SXMotionTween Extension
//
//  Created by Bruno Abrantes Basseto on 15/04/11.
//  bruno.basseto@uol.com.br
// -----------------------------------------------

#import <Foundation/Foundation.h>
#import "Sparrow.h"

typedef enum
{
	SEG_LINEAR,
	SEG_BEZIER2,
	SEG_BEZIER3
} SEG;

@interface SXMotionTweenPathSegment : NSObject {
	float x[4], y[4];
	float dx[3], dy[3];
	double duration;
	double angle;
	SEG seg;
}

@property (readonly) double duration;
@property (readonly) double angle;

+(id)lineFromPoint: (SPPoint *)p1 toPoint: (SPPoint *)p2 duration: (float)dur;
+(id)arcFromPoint: (SPPoint *)p1 toPoint: (SPPoint *)p2 andFocus: (SPPoint *)p3 duration: (float)dur;
+(id)curveFromPoint: (SPPoint *)p1 toPoint: (SPPoint *)p2 controlPoints: (SPPoint *)p3 and: (SPPoint *)p4 duration: (float)dur;
-(SPPoint *)positionWhen: (double)time;

@end
