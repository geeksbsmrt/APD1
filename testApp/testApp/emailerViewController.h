//
//  emailerViewController.h
//  testApp
//
//  Created by Adam Crawford on 2/27/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface emailerViewController : UIViewController <MFMailComposeViewControllerDelegate>

-(void)sendEmail:(MFMailComposeViewController*)email;

@end
