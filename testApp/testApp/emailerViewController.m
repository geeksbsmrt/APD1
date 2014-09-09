//
//  emailerViewController.m
//  testApp
//
//  Created by Adam Crawford on 2/27/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import "emailerViewController.h"

@interface emailerViewController ()

@end

@implementation emailerViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)sendEmail:(MFMailComposeViewController*)email
{
	UIViewController *presentingController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
	[presentingController presentViewController:email animated:YES completion:nil];
	
}

+ (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	switch (result)
    {
        case MFMailComposeResultCancelled:
		{
		NSLog(@"Mail cancelled");
		UIAlertView *notAllowed = [[UIAlertView alloc] initWithTitle:@"Not Allowed" message:@"You are not allowed to cancel sending this eamil." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		if (notAllowed) {
			[notAllowed show];
		}
		break;
		}
        case MFMailComposeResultSaved:
		{
		NSLog(@"Mail saved");
		UIAlertView *notAllowed = [[UIAlertView alloc] initWithTitle:@"Not Allowed" message:@"You are not allowed to cancel sending this eamil." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    // Close the Mail Interface
    [controller dismissViewControllerAnimated:YES completion:NULL];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
