//
//  AlarmsList.h
//  testApp
//
//  Created by Adam Crawford on 2/9/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmsList : NSObject
{

}
@property (nonatomic, strong) NSMutableArray *alarms;

+(AlarmsList*)alarms;


@end
