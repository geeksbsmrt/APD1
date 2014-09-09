//
//  SettingsViewController.m
//  testApp
//
//  Created by Adam Crawford on 2/3/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillBeHidden:)
												 name:UIKeyboardWillHideNotification object:nil];
	
	defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"outSubject"] != nil) {
		[outSub setText:[defaults objectForKey:@"outSubject"]];
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
	
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
	[scroll addGestureRecognizer:singleTap];
	
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
			//Save
			if ([outSub.text isEqualToString:@""]) {
				[defaults removeObjectForKey:@"outSubject"];
			} else {
				[defaults setValue:[NSString stringWithFormat:@"%@", outSub.text] forKey:@"outSubject"];
			}
			
			if ([to.text isEqualToString:@""]) {
				[defaults removeObjectForKey:@"to"];
			} else {
				[defaults setValue:[NSString stringWithFormat:@"%@", to.text] forKey:@"to"];
			}
			
			if ([subject.text isEqualToString:@""]) {
				[defaults removeObjectForKey:@"subject"];
			} else {
				[defaults setValue:[NSString stringWithFormat:@"%@", subject.text] forKey:@"subject"];
			}
			
			if ([lateBody.text isEqualToString:@""]) {
				[defaults removeObjectForKey:@"lateBody"];
			} else {
				[defaults setValue:[NSString stringWithFormat:@"%@", lateBody.text] forKey:@"lateBody"];
			}
			
			if ([outBody.text isEqualToString:@""]) {
				[defaults removeObjectForKey:@"outBody"];
			} else {
				[defaults setValue:[NSString stringWithFormat:@"%@", outBody.text] forKey:@"outBody"];
			}
			
			if ([snoozeDur.text isEqualToString:@""]) {
				[defaults removeObjectForKey:@"snoozeDur"];
			} else {
				[defaults setValue:[NSString stringWithFormat:@"%@", snoozeDur.text] forKey:@"snoozeDur"];
			}
			
			[defaults setValue:[NSNumber numberWithInt:(int)lateStepper.value] forKey:@"lateStepper"];
			[defaults setValue:[NSNumber numberWithInt:(int)outStepper.value] forKey:@"outStepper"];
			
			[defaults synchronize];
			
			status = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Your settings have been saved successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			if (status) {
				[status show];
			}
			break;

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
	switch (buttonIndex) {
		case 0:
			[self dismissViewControllerAnimated:YES completion:nil];
			break;
			
		default:
			break;
		
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



- (IBAction)showEmail:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Test Email";
    // Email Content
    NSString *messageBody = @"I'm Late :(";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"email@address.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
	
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
	
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
		NSLog(@"Mail cancelled");
		break;
        case MFMailComposeResultSaved:
		NSLog(@"Mail saved");
		break;
        case MFMailComposeResultSent:
		NSLog(@"Mail sent");
		break;
        case MFMailComposeResultFailed:
		NSLog(@"Mail sent failure: %@", [error localizedDescription]);
		break;
        default:
		break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
