//
//  AlarmsInfo.m
//  testApp
//
//  Created by Adam Crawford on 2/9/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import "AlarmsInfo.h"

@implementation AlarmsInfo

@synthesize alarmDays, alarmName, alarmTime, alarmTone, emailBody, emailSubject, fromEmail, lateSnoozes, outSnoozes, toEmail, snoozeLength;

-(id)initWithName:(NSString *)name time:(NSString *)time days:(NSMutableArray *)days lateSnoozes:(NSNumber *)late outSnoozes:(NSNumber *)outS toEmail:(NSString *)to fromEmail:(NSString *)from emailSubject:(NSString *)subject emailBody:(NSString *)body alarmTone:(NSString *)tone snoozeLength:(NSNumber *)length
{
	if (self = [super init]) {
		alarmDays = days;
		alarmName = name;
		alarmTime = time;
		alarmTone = tone;
		emailBody = body;
		emailSubject = subject;
		fromEmail = from;
		toEmail = to;
		lateSnoozes = late;
		outSnoozes = outS;
		snoozeLength = length;
		
	}
	return self;

}

@end
