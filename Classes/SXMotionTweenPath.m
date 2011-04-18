// -----------------------------------------------
//  SXMotionTweenPath.m
//  Sparrow Framework
//  SXMotionTween Extension
//
//  Created by Bruno Abrantes Basseto on 17/04/11.
//  bruno.basseto@uol.com.br
// -----------------------------------------------

#import "SXMotionTweenPath.h"

@implementation SXMotionTweenPath

#pragma mark -
#pragma mark Initialization and Release
+(id)path
{
	SXMotionTweenPath *s = [[[SXMotionTweenPath alloc] init] autorelease];
	if(!s) return nil;
	s->segments = [[NSMutableArray alloc] init];
	return s;
}

+(id)pathWithSegments: (NSArray *)segs
{
	SXMotionTweenPath *s = [[[SXMotionTweenPath alloc] init] autorelease];
	if(!s) return nil;
	s->segments = [[NSMutableArray alloc] initWithArray: segs];
	return s;
}

-(void)dealloc
{
	[segments release];
	[super dealloc];
}

#pragma mark -
#pragma mark Content access
-(int)count
{
	return [segments count];
}

-(SXMotionTweenPathSegment *)segmentAtIndex: (int)index
{
	return [segments objectAtIndex: index];
}

#pragma mark -
#pragma mark Path Building
-(void)startPoint: (SPPoint *)p
{
	lastX = p.x;
	lastY = p.y;
}

-(void)addLineToPoint: (SPPoint *)p duration: (float)dur
{
	SXMotionTweenPathSegment *seg = [SXMotionTweenPathSegment lineFromPoint: [SPPoint pointWithX: lastX y: lastY] toPoint: p duration: dur];
	[segments addObject: seg];
	lastX = p.x;
	lastY = p.y;							 
}

-(void)addArcToPoint: (SPPoint *)p withFocus: (SPPoint *)f duration: (float)dur
{
	SXMotionTweenPathSegment *seg = [SXMotionTweenPathSegment arcFromPoint: [SPPoint pointWithX: lastX y: lastY] toPoint: p andFocus: f duration: dur];
	[segments addObject: seg];
	lastX = p.x;
	lastY = p.y;							 
}

-(void)addCurveToPoint: (SPPoint *)p controlPoints: (SPPoint *)f1 and: (SPPoint *)f2 duration: (float)dur
{
	SXMotionTweenPathSegment *seg = [SXMotionTweenPathSegment curveFromPoint: [SPPoint pointWithX: lastX y: lastY] 
															 toPoint: p 
													   controlPoints: f1 and: f2 
															duration: dur];
	[segments addObject: seg];
	lastX = p.x;
	lastY = p.y;
}

@end
