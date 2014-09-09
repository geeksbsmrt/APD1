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
		[latePreview setHidden:NO];
		[outPreview setHidden:NO];
		//Set values from the alarm

		AlarmsInfo *editAlarm = [alarms objectAtIndex:sentAlarm];
		
		[name setText:[editAlarm alarmName]];
		[to setText:[editAlarm toEmail]];
		[outSubject setText:[editAlarm outSubject]];
		[subject setText:[editAlarm emailSubject]];
		[lateBody setText:[editAlarm lateBody]];
		[outBody setText:[editAlarm outBody]];
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

	} else {
		defaults = [NSUserDefaults standardUserDefaults];
		if ([defaults objectForKey:@"ouSubject"] != nil) {
			[outSubject setText:[defaults objectForKey:@"outSubject"]];
		}
		if ([defaults objectForKey:@"to"] != nil) {
			[to setText:[defaults objectForKey:@"to"]];
		}
		if ([defaults objectForKey:@"subject"] != nil) {
			[subject setText:[defaults objectForKey:@"subject"]];
		}
		if ([defaults objectForKey:@"lateBody"] != nil) {
			[lateBody setText:[defaults objectForKey:@"lateBody"]];
		}
		if ([defaults objectForKey:@"outBody"] != nil) {
			[outBody setText:[defaults objectForKey:@"outBody"]];
		}
		if ([defaults objectForKey:@"snoozeDur"] != nil) {
			[snoozeDur setText:[defaults objectForKey:@"snoozeDur"]];
		}
		if ([defaults objectForKey:@"lateStepper"] != nil) {
			[lateStepper setValue:[[defaults objectForKey:@"lateStepper"] doubleValue]];
			[lateSnoozes setText:[NSString stringWithFormat:@"%d", (int)lateStepper.value]];
		}
		if ([defaults objectForKey:@"outStepper"] != nil) {
			[outStepper setValue:[[defaults objectForKey:@"outStepper"] doubleValue]];
			[outSnoozes setText:[NSString stringWithFormat:@"%d", (int)outStepper.value]];
		}

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
			[editAlarm setLateBody: [lateBody text]];
			[editAlarm setOutBody: [outBody text]];
			[editAlarm setEmailSubject: [subject text]];
			[editAlarm setOutSubject: [outSubject text]];
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
			
			alarmDate =	picker.date;
			NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
			timeFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]];
			NSString *alarmTime = [timeFormatter stringFromDate:alarmDate];
			
			NSDictionary *alarmOptions = [[NSMutableDictionary alloc] init];
			
			[alarmOptions setValue:[NSNumber numberWithInt:(int)lateStepper.value] forKey:@"LateSnoozes"];
			[alarmOptions setValue:[NSNumber numberWithInt:(int)outStepper.value] forKey:@"OutSnoozes"];
			[alarmOptions setValue:[NSNumber numberWithInt:(int)lateStepper.value] forKey:@"OrigLateSnoozes"];
			[alarmOptions setValue:[NSNumber numberWithInt:(int)outStepper.value] forKey:@"OrigOutSnoozes"];
			[alarmOptions setValue:[NSString stringWithFormat:@"%@", [name text]] forKey:@"Name"];
			[alarmOptions setValue:[NSNumber numberWithInt:[snoozeDur.text intValue]] forKey:@"snoozeDur"];
			[alarmOptions setValue:[NSString stringWithFormat:@"%@", [outBody text]] forKey:@"OutBody"];
			[alarmOptions setValue:[NSString stringWithFormat:@"%@", [lateBody text]] forKey:@"LateBody"];
			[alarmOptions setValue:[NSString stringWithFormat:@"%@", [subject text]] forKey:@"Subject"];
			[alarmOptions setValue:[NSString stringWithFormat:@"%@", [outSubject text]] forKey:@"OutSubject"];
			[alarmOptions setValue:[NSString stringWithFormat:@"%@", [to text]] forKey:@"To"];
			[alarmOptions setValue:[NSString stringWithFormat:@"%@", [name text]] forKey:@"AlertTitle"];
			[alarmOptions setValue:[NSString stringWithFormat:@"%@", alarmTime] forKey:@"AlarmTime"];
			
			
			[scheduler scheduleNotification:picker.date options:alarmOptions];

			
			alarmDays = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithBool:[sun isOn]], [NSNumber numberWithBool:[mon isOn]], [NSNumber numberWithBool:[tue isOn]], [NSNumber numberWithBool:[wed isOn]], [NSNumber numberWithBool:[thu isOn]], [NSNumber numberWithBool:[fri isOn]], [NSNumber numberWithBool:[sat isOn]], nil];
			
				AlarmsInfo *alarm = [[AlarmsInfo alloc] initWithName:name.text time:alarmTime days:alarmDays lateSnoozes:[NSNumber numberWithDouble:(int)lateStepper.value] outSnoozes:[NSNumber numberWithDouble:(int)outStepper.value] toEmail:to.text outSubject:outSubject.text emailSubject:subject.text lateBody:lateBody.text outBody:outBody.text alarmTone:nil snoozeLength:[NSNumber numberWithInt:[snoozeDur.text intValue]]];
			
			
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
			break;
		case 3:
		{
			//Late Preview
			MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
			mc.mailComposeDelegate = self;
			[mc setSubject:subject.text];
			[mc setMessageBody:lateBody.text isHTML:NO];
			[mc setToRecipients:[NSArray arrayWithObject:to.text]];

			// Present mail view controller on screen
			[self presentViewController:mc animated:YES completion:nil];
			break;
		}
		case 4:
		{
			//Out Preview
			MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
			mc.mailComposeDelegate = self;
			[mc setSubject:subject.text];
			[mc setMessageBody:outBody.text isHTML:NO];
			[mc setToRecipients:[NSArray arrayWithObject:to.text]];
			
			// Present mail view controller on screen
			[self presentViewController:mc animated:YES completion:nil];
			break;
		}
		default:
			break;
	}
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
		{
			NSLog(@"Mail cancelled");
			UIAlertView *notAllowed = [[UIAlertView alloc] initWithTitle:@"Not Allowed" message:@"You are not allowed to cancel sending this eamil." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			if (notAllowed) {
				[notAllowed show];
			}
			break;
		}
        case MFMailComposeResultSaved:
		{
			NSLog(@"Mail saved");
			UIAlertView *notAllowed = [[UIAlertView alloc] initWithTitle:@"Not Allowed" message:@"You are not allowed to cancel sending this eamil." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			if (notAllowed) {
				[notAllowed show];
			}
			break;
		}
        case MFMailComposeResultSent:
		{
			NSLog(@"Mail sent");
			break;
		}
        case MFMailComposeResultFailed:
		{
			NSLog(@"Mail sent failure: %@", [error localizedDescription]);
			break;
		}
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
			[outStepper setMinimumValue:(stepper.value + 1)];
			[outSnoozes setText:[NSString stringWithFormat:@"%d", (int)outStepper.value]];
			if (lateStepper.value == 0) {
				[outStepper setMinimumValue:0];
			}
			break;
		case 1:
			//out
			[outSnoozes setText:[NSString stringWithFormat:@"%d", (int)stepper.value]];
			if (outStepper.value == lateStepper.value ) {
				[lateStepper setValue:(stepper.value - 1)];
				[lateSnoozes setText:[NSString stringWithFormat:@"%d", (int)stepper.value]];
			} else if (outStepper.value == 0) {
				[lateStepper setMinimumValue:0];
				[lateStepper setMaximumValue:100];
			}

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
			{
				
				NSArray *notifs = [[UIApplication sharedApplication] scheduledLocalNotifications];
				
				for (int i=0; i < notifs.count; i++) {
					if ([[[notifs[i] userInfo] objectForKey:@"AlarmTime"] isEqualToString:[[alarms objectAtIndex:(int)sentAlarm] alarmTime]]) {
						[[UIApplication sharedApplication] cancelLocalNotification:notifs[i]];
					}
				}
				[alarms removeObjectAtIndex:(int)sentAlarm];
				[self dismissViewControllerAnimated:YES completion:nil];
				break;
			}
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
