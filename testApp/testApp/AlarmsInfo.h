//
//  AlarmsInfo.h
//  testApp
//
//  Created by Adam Crawford on 2/9/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmsInfo : NSObject <NSCoding>
{
	
}

@property (strong, nonatomic) NSString *alarmName;
@property (strong, nonatomic) NSMutableArray *alarmDays;
@property (strong, nonatomic) NSString *alarmTime;
@property (strong, nonatomic) NSNumber *lateSnoozes;
@property (strong, nonatomic) NSNumber *outSnoozes;
@property (strong, nonatomic) NSString *alarmTone;
@property (strong, nonatomic) NSString *toEmail;
@property (strong, nonatomic) NSString *outSubject;
@property (strong, nonatomic) NSString *emailSubject;
@property (strong, nonatomic) NSString *lateBody;
@property (strong, nonatomic) NSString *outBody;
@property (strong, nonatomic) NSNumber *snoozeLength;
@property (strong, nonatomic) NSNumber *currentSnoozes;



-(id)initWithName:(NSString *)name time:(NSString *)time days:(NSMutableArray *)days lateSnoozes:(NSNumber *)lateSnoozes outSnoozes:(NSNumber *)outSnoozes toEmail:(NSString *)toEmail outSubject:(NSString *)outSub emailSubject:(NSString *)emailSubject lateBody:(NSString *)lateBod outBody:(NSString *)outBod alarmTone:(NSString *)tone snoozeLength:(NSNumber *)length;


@end
