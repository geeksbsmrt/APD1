//
//  AlarmsInfo.m
//  testApp
//
//  Created by Adam Crawford on 2/9/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import "AlarmsInfo.h"

@implementation AlarmsInfo

@synthesize alarmDays, alarmName, alarmTime, alarmTone, lateBody, outBody, emailSubject, outSubject, lateSnoozes, outSnoozes, toEmail, snoozeLength;

-(id)initWithName:(NSString *)name time:(NSString *)time days:(NSMutableArray *)days lateSnoozes:(NSNumber *)late outSnoozes:(NSNumber *)outS toEmail:(NSString *)to outSubject:(NSString *)outSub emailSubject:(NSString *)subject lateBody:(NSString *)lateBod outBody:(NSString *)outBod alarmTone:(NSString *)tone snoozeLength:(NSNumber *)length
{
	if (self = [super init]) {
		alarmDays = days;
		alarmName = name;
		alarmTime = time;
		alarmTone = tone;
		lateBody = lateBod;
		outBody = outBod;
		emailSubject = subject;
		outSubject = outSub;
		toEmail = to;
		lateSnoozes = late;
		outSnoozes = outS;
		snoozeLength = length;
		
		
	}
	return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.alarmDays forKey:@"alarmDays"];
	[aCoder encodeObject:self.alarmName forKey:@"alarmName"];
	[aCoder encodeObject:self.alarmTime forKey:@"alarmTime"];
	[aCoder encodeObject:self.alarmTone forKey:@"alarmTone"];
	[aCoder encodeObject:self.lateBody forKey:@"lateBody"];
	[aCoder encodeObject:self.outBody forKey:@"outBody"];
	[aCoder encodeObject:self.emailSubject forKey:@"emailSubject"];
	[aCoder encodeObject:self.outSubject forKey:@"outSubject"];
	[aCoder encodeObject:self.toEmail forKey:@"toEmail"];
	[aCoder encodeObject:self.lateSnoozes forKey:@"lateSnoozes"];
	[aCoder encodeObject:self.outSnoozes forKey:@"outSnoozes"];
	[aCoder encodeObject:self.snoozeLength forKey:@"snoozeLength"];
	[aCoder encodeObject:self.currentSnoozes forKey:@"currentSnoozes"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super init]) {
		self.alarmDays = [aDecoder decodeObjectForKey:@"alarmDays"];
		self.alarmName = [aDecoder decodeObjectForKey:@"alarmName"];
		self.alarmTime = [aDecoder decodeObjectForKey:@"alarmTime"];
		self.alarmTone = [aDecoder decodeObjectForKey:@"alarmTone"];
		self.lateBody = [aDecoder decodeObjectForKey:@"lateBody"];
		self.outBody = [aDecoder decodeObjectForKey:@"outBody"];
		self.emailSubject = [aDecoder decodeObjectForKey:@"emailSubject"];
		self.outSubject = [aDecoder decodeObjectForKey:@"outSubject"];
		self.toEmail = [aDecoder decodeObjectForKey:@"toEmail"];
		self.lateSnoozes = [aDecoder decodeObjectForKey:@"lateSnoozes"];
		self.outSnoozes = [aDecoder decodeObjectForKey:@"outSnoozes"];
		self.snoozeLength = [aDecoder decodeObjectForKey:@"snoozeLength"];
		self.currentSnoozes = [aDecoder decodeObjectForKey:@"currentSnoozes"];
	}
	return self;
}

@end
