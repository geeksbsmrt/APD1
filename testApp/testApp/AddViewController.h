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

@interface AddViewController : UIViewController <UIAlertViewDelegate>
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
	IBOutlet UITextView *body;
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
	IBOutlet UITextField *from;
	NSMutableArray *alarmDays;
	IBOutlet UIButton *commit;
	IBOutlet UIButton *remove;
	UIAlertView *confirm;
	int sentAlarm;
	UITextField *activeField;
	
}

@property (strong, nonatomic) NSDictionary *sending;

-(IBAction)onClick:(id)sender;
-(IBAction)onChange:(id)sender;

@end
