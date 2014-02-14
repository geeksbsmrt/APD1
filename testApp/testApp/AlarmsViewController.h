//
//  FirstViewController.h
//  testApp
//
//  Created by Adam Crawford on 2/3/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmsInfo.h"
#import "AlarmsList.h"
#import "CustomCell.h"
#import	"AddViewController.h"

@interface AlarmsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
	IBOutlet UILabel *none;
	IBOutlet UILabel *time;
	IBOutlet UIButton *control;
	NSDateFormatter *timeFormatter;
	NSDateFormatter *alarmFormatter;
	UIAlertView *alert;
	IBOutlet UITableView *table;
	AlarmsList *alarmsList;
	NSMutableArray *alarms;
	BOOL hrs;
}

-(void)tick:(id)sender;
-(BOOL)timeIs12HourFormat;
-(IBAction)onClick:(id)sender;

@end
