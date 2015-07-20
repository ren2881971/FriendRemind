//
//  NSObject+FRDateComponents.m
//  FriendRemind
//
//  Created by renfrank on 15/7/20.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import "NSDateComponents+FRDateComponents.h"

@implementation NSDateComponents (FRDateComponents)

+(BOOL) compare:(NSDateComponents *)oneComponents big:(NSDateComponents *)otherComponents
{
    BOOL flag ;
    if ([oneComponents month] > [otherComponents month]) {
        //fromDateCom is more
        flag = true;
    }else if ([oneComponents month] < [otherComponents month]){
        // fromDateCom is less
        flag = false;
    }else{
        // month same.
        if ([oneComponents date] < [otherComponents date]) {
            //fromDareCom is less
            flag = false;
        }else{
            //fromDateCom is more or same .
            flag = true;
        }
    }
    return flag;
}

@end
