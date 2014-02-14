//
//  CustomCell.h
//  testApp
//
//  Created by Adam Crawford on 2/9/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
	
}

@property (strong, nonatomic) IBOutlet UILabel *alarmName;
@property (strong, nonatomic) IBOutlet UILabel *alarmTime;
@property (strong, nonatomic) IBOutlet UILabel *toEmail;
@property (strong, nonatomic) IBOutlet UILabel *sub;

@end
