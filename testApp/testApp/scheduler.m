//
//  scheduler.m
//  testApp
//
//  Created by Adam Crawford on 2/26/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import "scheduler.h"

@implementation scheduler


+(void)scheduleNotification:(NSDate *)date options:(NSDictionary *)options
{
	NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
	timeFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]];



	NSDateComponents *timeComponents = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit)fromDate:date];

	NSDateFormatter *test = [[NSDateFormatter alloc] init];
	[test setDateStyle:NSDateFormatterMediumStyle];
	NSDate *myDate = [test dateFromString:[test stringFromDate:[NSDate date]]];

	NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:myDate];
	[components setHour:timeComponents.hour];
	[components setMinute:timeComponents.minute];


	NSDate *itemDate = [calendar dateFromComponents:components];

	UILocalNotification *localNotif = [[UILocalNotification alloc] init];
	if (localNotif == nil)
	return;
	localNotif.fireDate = itemDate;
	localNotif.timeZone = [NSTimeZone defaultTimeZone];
	

	// Notification details
	localNotif.alertBody = [NSString stringWithFormat:@"Snoozes remaining until late: %@\nSnoozes remaing until out: %@", [options objectForKey:@"LateSnoozes"], [options objectForKey:@"OutSnoozes"]];
	// Set the action button
	localNotif.alertAction = @"View";

	localNotif.soundName = UILocalNotificationDefaultSoundName;
	localNotif.applicationIconBadgeNumber += 1;

	// Specify custom data for the notification
	//NSDictionary *infoDict = [NSDictionary dictionaryWithObject:[options objectForKey:@"Name"] forKey:@"alertTitle"];
	localNotif.userInfo = options;

	// Schedule the notification
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
	NSLog(@"Alarm Scheduled for %@", itemDate);

}


+(void)receiveNotifictaion:(UILocalNotification *)notification
{
	notif = notification;
	
	NSLog(@"%@", [notification description]);
		
	UIAlertView *display = [[UIAlertView alloc] initWithTitle:[[notification userInfo] objectForKey:@"alertTitle"] message:notification.alertBody delegate:self cancelButtonTitle:@"Snooze" otherButtonTitles:@"Dismiss", nil];
	
	if (display) {
		[display show];
	}
	
}


+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
		{
			//Snooze
		NSLog(@"Clicked snooze");
		
		// Decrease icon badge count
		[UIApplication sharedApplication].applicationIconBadgeNumber -= 1;
		
			if ([[[notif userInfo] objectForKey:@"OutSnoozes"] intValue] == 0) {
				
				NSLog(@"Sending out email");
				//Send out email
				NSString *emailTitle = [[notif userInfo] objectForKey:@"OutSubject"];
				// Email Content
				NSString *messageBody = [[notif userInfo] objectForKey:@"OutBody"];
				// To address
				NSArray *toRecipents = [NSArray arrayWithObject:[[notif userInfo] objectForKey:@"To"]];
				
				MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
				mc.mailComposeDelegate = [emailerViewController self];
				[mc setSubject:emailTitle];
				[mc setMessageBody:messageBody isHTML:NO];
				[mc setToRecipients:toRecipents];
				
				// Present mail view controller on screen
				
				[[emailerViewController alloc] sendEmail:mc];
				
				//Reschedule alarm if repeat days are selected
				
				NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
				timeFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]];
				NSDate *resched = [NSDate dateWithTimeInterval:86400 sinceDate:[timeFormatter dateFromString:[[notif userInfo] objectForKey:@"AlarmTime"]]];
				
				NSMutableDictionary *reUserInfo = [[NSMutableDictionary alloc] initWithDictionary:[notif userInfo]];
				
				[reUserInfo setValue:[NSNumber numberWithInt:[[[notif userInfo] objectForKey:@"OrigLateSnoozes"] intValue]] forKey:@"LateSnoozes"];
				[reUserInfo setValue:[NSNumber numberWithInt:[[[notif userInfo] objectForKey:@"OrigOutSnoozes"] intValue]] forKey:@"OutSnoozes"];

				[self scheduleNotification:resched options:(NSDictionary*)reUserInfo];
				
			} else if ([[[notif userInfo] objectForKey:@"LateSnoozes"] intValue] == 0 && ![[notif userInfo] objectForKey:@"lateSent"] ) {
				
				NSLog(@"Sending Late email");
				//Send Late email
				
				//Send out email
				NSString *emailTitle = [[notif userInfo] objectForKey:@"Subject"];
				// Email Content
				NSString *messageBody = [[notif userInfo] objectForKey:@"LateBody"];
				// To address
				NSArray *toRecipents = [NSArray arrayWithObject:[[notif userInfo] objectForKey:@"To"]];
				
				MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
				mc.mailComposeDelegate = [emailerViewController self];
				[mc setSubject:emailTitle];
				[mc setMessageBody:messageBody isHTML:NO];
				[mc setToRecipients:toRecipents];
				
				// Present mail view controller on screen
				
				[[emailerViewController alloc] sendEmail:mc];
				
				//Reschedule alarm with out snoozes
				NSDate *resched = [NSDate dateWithTimeIntervalSinceNow:[[[notif userInfo] objectForKey:@"snoozeDur"] intValue] * 60];
				NSMutableDictionary *reUserInfo = [[NSMutableDictionary alloc] initWithDictionary:[notif userInfo]];
				
				[reUserInfo setValue:[NSNumber numberWithInt:[[[notif userInfo] objectForKey:@"OutSnoozes"] intValue] - 1] forKey:@"OutSnoozes"];
				
				[self scheduleNotification:resched options:(NSDictionary*)reUserInfo];
				
			} else if ([[[notif userInfo] objectForKey:@"LateSnoozes"] intValue] == 0 && [[notif userInfo] objectForKey:@"lateSent"]){
				
				NSLog(@"Rescheduling with out");
				
				//Reschedule alarm with out snoozes
				NSDate *resched = [NSDate dateWithTimeIntervalSinceNow:[[[notif userInfo] objectForKey:@"snoozeDur"] intValue] * 60];
				NSMutableDictionary *reUserInfo = [[NSMutableDictionary alloc] initWithDictionary:[notif userInfo]];
				
				[reUserInfo setValue:[NSNumber numberWithInt:[[[notif userInfo] objectForKey:@"OutSnoozes"] intValue] - 1] forKey:@"OutSnoozes"];
				
				[self scheduleNotification:resched options:(NSDictionary*)reUserInfo];
				
			} else {
				
				NSLog(@"Rescheduling with late and out");
				//reschedule alarm with both snoozes
				
				NSDate *resched = [NSDate dateWithTimeIntervalSinceNow:[[[notif userInfo] objectForKey:@"snoozeDur"] intValue] * 60];
				NSMutableDictionary *reUserInfo = [[NSMutableDictionary alloc] initWithDictionary:[notif userInfo]];
				
				[reUserInfo setValue:[NSNumber numberWithInt:[[[notif userInfo] objectForKey:@"LateSnoozes"] intValue] - 1] forKey:@"LateSnoozes"];
				[reUserInfo setValue:[NSNumber numberWithInt:[[[notif userInfo] objectForKey:@"OutSnoozes"] intValue] - 1] forKey:@"OutSnoozes"];
				
				[self scheduleNotification:resched options:(NSDictionary*)reUserInfo];
			}
		
		break;
		}
		case 1:
		{
			//Dismiss
			NSLog(@"Clicked dismiss");
			// Decrease icon badge count
			[UIApplication sharedApplication].applicationIconBadgeNumber -= 1;
			
			//reschedule
			NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
			timeFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]];
			NSDate *resched = [NSDate dateWithTimeInterval:86400 sinceDate:[timeFormatter dateFromString:[[notif userInfo] objectForKey:@"AlarmTime"]]];
			
			NSMutableDictionary *reUserInfo = [[NSMutableDictionary alloc] initWithDictionary:[notif userInfo]];
			[reUserInfo setValue:[NSNumber numberWithInt:[[[notif userInfo] objectForKey:@"OrigLateSnoozes"] intValue]] forKey:@"LateSnoozes"];
			[reUserInfo setValue:[NSNumber numberWithInt:[[[notif userInfo] objectForKey:@"OrigOutSnoozes"] intValue]] forKey:@"OutSnoozes"];
			
			[self scheduleNotification:resched options:reUserInfo];
			[[UIApplication sharedApplication] cancelLocalNotification:notif];
			break;
		}
		default:
			NSLog(@"Default");
			break;
	}
}

@end
