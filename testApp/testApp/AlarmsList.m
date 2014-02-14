//
//  AlarmsList.m
//  testApp
//
//  Created by Adam Crawford on 2/9/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import "AlarmsList.h"

@implementation AlarmsList

@synthesize alarms;

static AlarmsList* _alarms = nil;

+(AlarmsList *)alarms
{
	if (! _alarms) {
		_alarms = [[self alloc] init];
	}
	
	return _alarms;
}

-(id)init
{
	if (self = [super init]) {
		alarms	= [[NSMutableArray alloc] init];
	}
	
	return self;
}

@end
