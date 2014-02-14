//
//  defaults.h
//  testApp
//
//  Created by Adam Crawford on 2/9/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface defaults : NSObject
{
	NSMutableDictionary *defaultsList;
}

@property (strong, nonatomic) NSNumber *lateSnoozes;
@property (strong, nonatomic) NSNumber *outSnoozes;
@property (strong, nonatomic) NSString *alarmTone;
@property (strong, nonatomic) NSString *toEmail;
@property (strong, nonatomic) NSString *fromEmail;
@property (strong, nonatomic) NSString *emailSubject;
@property (strong, nonatomic) NSString *emailBody;
@property (strong, nonatomic) NSNumber *snoozeLength;




@end
