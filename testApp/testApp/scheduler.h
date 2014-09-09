//
//  scheduler.h
//  testApp
//
//  Created by Adam Crawford on 2/26/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "emailerViewController.h"

static UILocalNotification *notif;

@interface scheduler : NSObject <MFMailComposeViewControllerDelegate, UIAlertViewDelegate>
{

}

+(void)scheduleNotification:(NSDate *)date options:(NSDictionary *)options;
+(void)receiveNotifictaion:(UILocalNotification *)notification;

@end
