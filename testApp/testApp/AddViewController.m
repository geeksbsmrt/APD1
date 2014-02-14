//
//  AddViewController.m
//  testApp
//
//  Created by Adam Crawford on 2/5/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize sending;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillBeHidden:)
												 name:UIKeyboardWillHideNotification object:nil];
	
//	[scroll setContentSize:CGSizeMake(320,800)];
	
	
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
	[scroll addGestureRecognizer:singleTap];
	
	
	alarmsList = [AlarmsList alarms];
	if (alarmsList) {
		alarms = alarmsList.alarms;
	}
	
	if (sending) {
		sentAlarm = [[sending objectForKey:@"index"] intValue];
		
		
		[commit setTitle:@"Save" forState:UIControlStateNormal];
		[remove setHidden:NO];
		//Set values from the alarm

		AlarmsInfo *editAlarm = [alarms objectAtIndex:sentAlarm];
		
		[name setText:[editAlarm alarmName]];
		[to setText:[editAlarm toEmail]];
		[from setText:[editAlarm fromEmail]];
		[subject setText:[editAlarm emailSubject]];
		[body setText:[editAlarm emailBody]];
		[sun setOn:[[[editAlarm alarmDays]objectAtIndex:0] boolValue]];
		[mon setOn:[[[editAlarm alarmDays]objectAtIndex:1] boolValue]];
		[tue setOn:[[[editAlarm alarmDays]objectAtIndex:2] boolValue]];
		[wed setOn:[[[editAlarm alarmDays]objectAtIndex:3] boolValue]];
		[thu setOn:[[[editAlarm alarmDays]objectAtIndex:4] boolValue]];
		[fri setOn:[[[editAlarm alarmDays]objectAtIndex:5] boolValue]];
		[sat setOn:[[[editAlarm alarmDays]objectAtIndex:6] boolValue]];
		[snoozeDur setText:[[editAlarm snoozeLength] stringValue]];
		[lateSnoozes setText:[[editAlarm lateSnoozes] stringValue]];
		[lateStepper setValue:[[editAlarm lateSnoozes] intValue]];
		[outSnoozes setText:[[editAlarm outSnoozes] stringValue]];
		[outStepper setValue:[[editAlarm outSnoozes] intValue]];
		
		NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
		timeFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]];
		[picker setDate:[timeFormatter dateFromString:[editAlarm alarmTime]]];
		
		
	}
//	NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
//	NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit)fromDate:picker.date];
//
//	NSDate *itemTime = [calendar dateFromComponents:timeComponents];
//	
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
	[self.view endEditing:YES];
}


-(IBAction)onClick:(id)sender
{
	UIButton *clicked = (UIButton *)sender;
	
	switch (clicked.tag) {
		case 0:
		{
		
		if (sending) {
			AlarmsInfo *editAlarm = [alarms objectAtIndex:sentAlarm];
			
			alarmDays = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithBool:[sun isOn]], [NSNumber numberWithBool:[mon isOn]], [NSNumber numberWithBool:[tue isOn]], [NSNumber numberWithBool:[wed isOn]], [NSNumber numberWithBool:[thu isOn]], [NSNumber numberWithBool:[fri isOn]], [NSNumber numberWithBool:[sat isOn]], nil];
			
			alarmDate =	picker.date;
			NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
			timeFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]];
			NSString *alarmTime = [timeFormatter stringFromDate:alarmDate];
			
			[editAlarm setAlarmDays: alarmDays];
			[editAlarm setAlarmName: [name text]];
			[editAlarm setAlarmTime: alarmTime];
			[editAlarm setAlarmTone:nil];
			[editAlarm setEmailBody: [body text]];
			[editAlarm setEmailSubject: [subject text]];
			[editAlarm setFromEmail: [from text]];
			[editAlarm setToEmail: [to text]];
			[editAlarm setLateSnoozes: [NSNumber numberWithDouble:(int)lateStepper.value]];
			[editAlarm setOutSnoozes: [NSNumber numberWithDouble:(int)outStepper.value]];
			[editAlarm setSnoozeLength:[NSNumber numberWithInt:[snoozeDur.text intValue]]];
			
			[alarms replaceObjectAtIndex:sentAlarm withObject:editAlarm];
			
			NSString *alertMessage = [NSString stringWithFormat:@"%@ has been saved for %@.", [name text], alarmTime];
			status = [[UIAlertView alloc] initWithTitle:@"Alarm Saved" message:alertMessage	delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
			if (status) {
				[status show];
			}
			
		} else {
			//Save stuff
			NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
			alarmDate =	picker.date;
			NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
			timeFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]];
			NSString *alarmTime = [timeFormatter stringFromDate:alarmDate];

		
		NSDateComponents *timeComponents = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit)fromDate:picker.date];

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
		localNotif.alertBody = @"Test";;
		// Set the action button
		localNotif.alertAction = @"View";
		
		localNotif.soundName = UILocalNotificationDefaultSoundName;
		localNotif.applicationIconBadgeNumber = 1;
		
		// Specify custom data for the notification
		//NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
		//localNotif.userInfo = infoDict;
		
		// Schedule the notification
		[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
		
		alarmDays = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithBool:[sun isOn]], [NSNumber numberWithBool:[mon isOn]], [NSNumber numberWithBool:[tue isOn]], [NSNumber numberWithBool:[wed isOn]], [NSNumber numberWithBool:[thu isOn]], [NSNumber numberWithBool:[fri isOn]], [NSNumber numberWithBool:[sat isOn]], nil];
		
		AlarmsInfo *alarm = [[AlarmsInfo alloc] initWithName:name.text time:alarmTime days:alarmDays lateSnoozes:[NSNumber numberWithDouble:(int)lateStepper.value] outSnoozes:[NSNumber numberWithDouble:(int)outStepper.value] toEmail:to.text fromEmail:from.text emailSubject:subject.text emailBody:body.text alarmTone:nil snoozeLength:[NSNumber numberWithInt:[snoozeDur.text intValue]]];
		
		
		[alarms addObject:alarm];
			
			NSString *alertMessage = [NSString stringWithFormat:@"%@ has been set for %@.", [name text], alarmTime];
			status = [[UIAlertView alloc] initWithTitle:@"Alarm Saved" message:alertMessage	delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
			if (status) {
				[status show];
			}
		}
			break;
		}
		case 1:
			//Cancel
			 [self dismissViewControllerAnimated:TRUE completion:nil];
			break;
		case 2:
			//Delete
			confirm = [[UIAlertView alloc] initWithTitle:@"Confirm Delete" message:[NSString stringWithFormat:@"Are you sure you want to delete %@?", [[alarms objectAtIndex:sentAlarm] alarmName]] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
			[confirm show];
		default:
			break;
	}
}

-(IBAction)onChange:(id)sender
{
	UIStepper *stepper = (UIStepper*)sender;
	
	switch (stepper.tag) {
		case 0:
			//Late
			
			[lateSnoozes setText:[NSString stringWithFormat:@"%d", (int)stepper.value]];
			
			break;
		case 1:
			//out
			[outSnoozes setText:[NSString stringWithFormat:@"%d", (int)stepper.value]];
			break;
		default:
			break;
	}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if ([alertView.title isEqualToString:@"Confirm Delete"]) {
		switch (buttonIndex) {
			case 0:
				[alarms removeObjectAtIndex:(int)sentAlarm];
				[self dismissViewControllerAnimated:YES completion:nil];
				break;
			default:
				break;
		}

	} else {
		switch (buttonIndex) {
			case 0:
				[self dismissViewControllerAnimated:YES completion:nil];				
				break;
				
			default:
				break;
		}

	}
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}


- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scroll.contentInset = contentInsets;
    scroll.scrollIndicatorInsets = contentInsets;
	
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [scroll scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scroll.contentInset = contentInsets;
    scroll.scrollIndicatorInsets = contentInsets;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
