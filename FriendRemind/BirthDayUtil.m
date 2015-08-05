//
//  BirthDayUtil.m
//  FriendRemind
//
//  Created by renfrank on 15/8/2.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import "BirthDayUtil.h"
#import "NSDateComponents+FRDateComponents.h"
@implementation BirthDayUtil
/**< 计算现在时间距离生日时间还剩多少天 */
- (NSString *) howlongFromDate:(NSString *)fromDate
{
    //处理fromDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //中国东八时区
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    NSDate *fromDateObj = [dateFormatter dateFromString:fromDate];
    //处理当前时间
    NSDate *date = [NSDate date];
    
    NSDate *localeDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
    
    NSDateComponents *fromDateCom = [NSDateComponents  getDateComponents:fromDateObj];
    
    NSDateComponents *localDateCom = [NSDateComponents getDateComponents:localeDate];
    
    //比较 NSDateComponents 的 月 和 日 大小。
    
    BOOL big = [NSDateComponents compare:fromDateCom big:localDateCom];
    NSInteger localMon = [localDateCom month];
    NSInteger fromMon = [fromDateCom month];
    
    if (big) {
        if (localMon == fromMon) {
            NSInteger fromDate = [fromDateCom day];
            NSInteger localDate = [localDateCom day];
            NSInteger minusDay = fromDate - localDate;
            return [NSString stringWithFormat:@"%ld",(long)minusDay];
        }else{
            //loop the monthe between localMon and fromMon
            NSInteger sumOfDaysInMinusMonth = 0;
            for (NSInteger i = localMon+1 ; i < fromMon; i++) {
                sumOfDaysInMinusMonth += [NSDateComponents theDaysInMonth:i];
            }
            NSInteger localDayRemain = [NSDateComponents theDaysInMonth:localMon] - [localDateCom day];
            NSInteger fromDayRemain = [fromDateCom day];
            NSInteger result = sumOfDaysInMinusMonth + localDayRemain + fromDayRemain;
            return [NSString stringWithFormat:@"%ld",(long)result];
        }
    }else{
        //all days of year - (from - local)
        // fromDate is less
        NSInteger result = 0;
        if (localMon == fromMon) {
            result = [localDateCom day] - [fromDateCom day];
        }else{
            NSInteger sumOfDaysInMinusMonth = 0;
            for (NSInteger i = fromMon + 1 ; i< localMon; i++) {
                sumOfDaysInMinusMonth += [NSDateComponents theDaysInMonth:i];
            }
            NSInteger fromDayRemain = [NSDateComponents theDaysInMonth:fromMon] - [fromDateCom day];
            NSInteger localDayRemain = [localDateCom day];
            NSInteger theDaysOfYear = [NSDateComponents theDayOfYear:[localDateCom year]];
            result = theDaysOfYear - (sumOfDaysInMinusMonth + fromDayRemain + localDayRemain);
        }
        return [NSString stringWithFormat:@"%ld",(long)result];
    }
}
@end
