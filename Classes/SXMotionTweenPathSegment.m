// -----------------------------------------------
//  SXMotionTweenPathSegment.m
//  Sparrow Framework
//  SXMotionTween Extension
//
//  Created by Bruno Abrantes Basseto on 15/04/11.
//  bruno.basseto@uol.com.br
// -----------------------------------------------

#import "SXMotionTweenPathSegment.h"

@implementation SXMotionTweenPathSegment
@synthesize duration, angle;

#pragma mark -
#pragma mark Initialization Class Methods
+(id)lineFromPoint: (SPPoint *)p1 toPoint: (SPPoint *)p2 duration: (float)dur
{
	SXMotionTweenPathSegment *s = [[[SXMotionTweenPathSegment alloc] init] autorelease];
	if(!s) return nil;
	
	s->x[0] = p1.x;
	s->y[0] = p1.y;
	s->x[3] = p2.x;
	s->y[3] = p2.y;

	s->dx[0] = p2.x - p1.x;
	s->dy[0] = p2.y - p1.y;
	
	s->duration = dur;
	s->angle = atan2(p2.y - p1.y, p2.x - p1.x);
	s->seg = SEG_LINEAR;
	return s;
}

+(id)arcFromPoint: (SPPoint *)p1 toPoint: (SPPoint *)p2 andFocus: (SPPoint *)p3 duration: (float)dur
{
	SXMotionTweenPathSegment *s = [[[SXMotionTweenPathSegment alloc] init] autorelease];
	if(!s) return nil;

	s->x[0] = p1.x;
	s->y[0] = p1.y;
	s->x[3] = p2.x;
	s->y[3] = p2.y;
	s->x[1] = p3.x;
	s->y[1] = p3.y;

	s->dx[0] = p2.x - p1.x;
	s->dy[0] = p2.y - p1.y;
	s->dx[1] = p2.x - p3.x;
	s->dy[1] = p2.y - p3.y;

	s->duration = dur;
	s->seg = SEG_BEZIER2;
	return s;
}

+(id)curveFromPoint: (SPPoint *)p1 toPoint: (SPPoint *)p2 controlPoints: (SPPoint *)p3 and: (SPPoint *)p4 duration: (float)dur
{
	SXMotionTweenPathSegment *s = [[[SXMotionTweenPathSegment alloc] init] autorelease];
	if(!s) return nil;
	
	s->x[0] = p1.x;
	s->y[0] = p1.y;
	s->x[3] = p2.x;
	s->y[3] = p2.y;
	s->x[1] = p3.x;
	s->y[1] = p3.y;
	s->x[2] = p4.x;
	s->y[2] = p4.y;

	s->dx[0] = p3.x - p1.x;
	s->dy[0] = p3.y - p1.y;
	s->dx[1] = p4.x - p3.x;
	s->dy[1] = p4.y - p3.y;
	s->dx[2] = p2.x - p4.x;
	s->dy[2] = p2.y - p4.y;
	
	s->duration = dur;
	s->seg = SEG_BEZIER3;
	return s;
}

#pragma mark -
#pragma mark Interpolation Function
-(SPPoint *)positionWhen: (double)time
{
	float xx, yy, vx, vy, tmp;
	double t1, t2;
	
	if(time < 0) return [SPPoint pointWithX: x[0] y: y[0]];
	if(time > duration) return [SPPoint pointWithX: x[3] y: y[3]];
	
	double t = time/duration;
	
	switch(seg) {
		// --------------------
		// linear interpolation
		// --------------------
		case SEG_LINEAR:	
			xx = x[0] + t * dx[0];
			yy = y[0] + t * dy[0];
			break;
		
		// ------------------------------
		// quadradic bezier interpolation
		// ------------------------------
		case SEG_BEZIER2:
			t1 = 1 - t;
			t2 = t;
			
			vx = 2*t1*dx[0] + 2*t2*dx[1];
			vy = 2*t1*dy[0] + 2*t2*dy[1];
			angle = atan2(vy, vx);
			
			tmp = 2 * t1 * t2;
			xx = tmp * x[1];
			yy = tmp * y[1];
			
			t1 *= t1;
			t2 *= t2;
			
			xx += (t1 * x[0] + t2 * x[3]);
			yy += (t1 * y[0] + t2 * y[3]);
			break;
		
		// --------------------------
		// cubic bezier interpolation
		// --------------------------
		case SEG_BEZIER3:
			t1 = 1 - t;
			t2 = t * t;
			
			tmp = 3 * t1 * t2;
			xx = tmp * x[2];
			yy = tmp * y[2];
			
			tmp = 6 * t1 * t;
			vx = tmp * dx[1];
			vy = tmp * dy[1];
			
			tmp = 3*t2*(1-2*t1);
			vx += (tmp * dx[2]);
			vy += (tmp * dy[2]);
			
			t1 *= t1;
			tmp = 3 * t1 * t;
			xx += (tmp * x[1]);
			yy += (tmp * y[1]);
			
			tmp = 3*t1;
			vx += (tmp * dx[0]);
			vy += (tmp * dy[0]);
			
			angle = atan2(vy, vx);
			
			t1 *= t1;
			t2 *= t2;
			xx += (t1 * x[0] + t2 * x[3]);
			yy += (t1 * y[0] + t2 * y[3]);
			break;
	}
	
	return [SPPoint pointWithX: xx y: yy];
}

@end
