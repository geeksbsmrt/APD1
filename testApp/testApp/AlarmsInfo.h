//
//  AlarmsInfo.h
//  testApp
//
//  Created by Adam Crawford on 2/9/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmsInfo : NSObject
{
	
}

@property (strong, nonatomic) NSString *alarmName;
@property (strong, nonatomic) NSMutableArray *alarmDays;
@property (strong, nonatomic) NSString *alarmTime;
@property (strong, nonatomic) NSNumber *lateSnoozes;
@property (strong, nonatomic) NSNumber *outSnoozes;
@property (strong, nonatomic) NSString *alarmTone;
@property (strong, nonatomic) NSString *toEmail;
@property (strong, nonatomic) NSString *fromEmail;
@property (strong, nonatomic) NSString *emailSubject;
@property (strong, nonatomic) NSString *emailBody;
@property (strong, nonatomic) NSNumber *snoozeLength;



-(id)initWithName:(NSString *)name time:(NSString *)time days:(NSMutableArray *)days lateSnoozes:(NSNumber *)lateSnoozes outSnoozes:(NSNumber *)outSnoozes toEmail:(NSString *)toEmail fromEmail:(NSString *)fromEmail emailSubject:(NSString *)emailSubject emailBody:(NSString *)emailBody alarmTone:(NSString *)alarmTone snoozeLength:(NSNumber *)length;


@end
