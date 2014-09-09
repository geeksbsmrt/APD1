//
//  SettingsViewController.h
//  testApp
//
//  Created by Adam Crawford on 2/3/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SettingsViewController : UIViewController <MFMailComposeViewControllerDelegate, UIAlertViewDelegate>
{
	IBOutlet UITextView *defaultBodyText;
	IBOutlet UIView *content;
	IBOutlet UIScrollView *scroll;
	IBOutlet UITextField *snoozeDur;
	IBOutlet UILabel *outSnoozes;
	IBOutlet UILabel *lateSnoozes;
	IBOutlet UITextField *to;
	IBOutlet UITextField *subject;
	IBOutlet UITextView *lateBody;
	IBOutlet UITextView *outBody;
	IBOutlet UIStepper *outStepper;
	IBOutlet UIStepper *lateStepper;
	IBOutlet UITextField *outSub;
	NSUserDefaults *defaults;
	UITextField *activeField;
	UIAlertView *status;
}

-(IBAction)onClick:(id)sender;
-(IBAction)onChange:(id)sender;
-(IBAction)showEmail:(id)sender;
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;

@end
