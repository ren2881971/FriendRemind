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

+(NSDateComponents *) getDateComponents:(NSDate *) date
{
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    
    NSDateComponents *calComponts = [calendar components:unitFlags fromDate:date];
    
    return calComponts;
}

+ (NSInteger) theDaysInMonth:(NSInteger) month
{
    NSDateComponents  *nowDateComponents = [NSDateComponents getDateComponents:[NSDate date]];
    NSInteger year = [nowDateComponents year];
    if (month == 1||month == 3||month == 5||month == 7||month == 8||month == 10||month == 12) {
        return 31;
    }else if (month == 4||month == 6||month == 9||month == 11) {
        return 30;
    }else{
        if ((year %4 == 0 && year %100 != 0) || (year %100 == 0 && year %400 ==0)){
            return 29;
        }else{
            return 28;
        }
    }
}
+ (NSInteger) theDayOfYear:(NSInteger) year
{
    if ((year %4 == 0 && year %100 != 0) || (year %100 == 0 && year %400 ==0)){
        return 366;
    }else{
        return 365;
    }
}
@end
