//
//  AddViewController.h
//  testApp
//
//  Created by Adam Crawford on 2/5/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmsList.h"
#import "AlarmsInfo.h"
#import <MessageUI/MessageUI.h>
#import "scheduler.h"

@interface AddViewController : UIViewController <UIAlertViewDelegate, MFMailComposeViewControllerDelegate>
{
	IBOutlet UIDatePicker *picker;
	UIAlertView *status;
	NSDate *alarmDate;
	AlarmsList *alarmsList;
	NSMutableArray *alarms;
	IBOutlet UIScrollView *scroll;
	IBOutlet UITextField *snoozeDur;
	IBOutlet UILabel *outSnoozes;
	IBOutlet UILabel *lateSnoozes;
	IBOutlet UITextField *to;
	IBOutlet UITextField *subject;
	IBOutlet UITextView *lateBody;
	IBOutlet UITextView *outBody;
	IBOutlet UISwitch *sun;
	IBOutlet UISwitch *mon;
	IBOutlet UISwitch *tue;
	IBOutlet UISwitch *wed;
	IBOutlet UISwitch *thu;
	IBOutlet UISwitch *fri;
	IBOutlet UISwitch *sat;
	IBOutlet UIStepper *outStepper;
	IBOutlet UIStepper *lateStepper;
	IBOutlet UITextField *name;
	IBOutlet UITextField *outSubject;
	NSMutableArray *alarmDays;
	IBOutlet UIButton *commit;
	IBOutlet UIButton *remove;
	UIAlertView *confirm;
	int sentAlarm;
	UITextField *activeField;
	NSUserDefaults *defaults;
	IBOutlet UIButton *latePreview;
	IBOutlet UIButton *outPreview;
	
}

@property (strong, nonatomic) NSDictionary *sending;

-(IBAction)onClick:(id)sender;
-(IBAction)onChange:(id)sender;
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;


@end
