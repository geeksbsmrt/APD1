//
//  SettingsViewController.h
//  testApp
//
//  Created by Adam Crawford on 2/3/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SettingsViewController : UIViewController <MFMailComposeViewControllerDelegate, UIScrollViewDelegate>
{
	IBOutlet UITextView *defaultBodyText;
	IBOutlet UIView *content;
	IBOutlet UIScrollView *scroll;
}

-(IBAction)onClick:(id)sender;
-(IBAction)showEmail:(id)sender;
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;

@end
