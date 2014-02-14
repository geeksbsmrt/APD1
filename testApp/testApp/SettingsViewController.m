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
	
	
	[scroll setContentSize:CGSizeMake(320,580)];
	
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
			//Login
			
			break;
		case 1:
			//Recipients
			
			break;
		default:
			break;
	}
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
