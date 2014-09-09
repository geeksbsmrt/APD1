//
//  AppDelegate.h
//  testApp
//
//  Created by Adam Crawford on 2/3/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmsList.h"
#import "scheduler.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
	AlarmsList *alarmsList;
}

@property (strong, nonatomic) UIWindow *window;

@end
