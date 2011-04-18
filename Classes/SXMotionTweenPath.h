// -----------------------------------------------
//  SXMotionTweenPath.h
//  Sparrow Framework
//  SXMotionTween Extension
//
//  Created by Bruno Abrantes Basseto on 17/04/11.
//  bruno.basseto@uol.com.br
// -----------------------------------------------

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "SXMotionTweenPathSegment.h"

@interface SXMotionTweenPath : NSObject {
	NSMutableArray *segments;
	float lastX, lastY;
}

+(id)path;
+(id)pathWithSegments: (NSArray *)segs;
-(int)count;
-(SXMotionTweenPathSegment *)segmentAtIndex: (int)index;
-(void)startPoint: (SPPoint *)p;
-(void)addLineToPoint: (SPPoint *)p duration: (float)dur;
-(void)addArcToPoint: (SPPoint *)p withFocus: (SPPoint *)f duration: (float)dur;
-(void)addCurveToPoint: (SPPoint *)p controlPoints: (SPPoint *)f1 and: (SPPoint *)f2 duration: (float)dur;
-(void)dealloc;

@end
