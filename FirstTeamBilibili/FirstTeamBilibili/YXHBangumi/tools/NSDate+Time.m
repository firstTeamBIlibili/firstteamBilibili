//
//  NSDate+Time.m
//  24-百思不得姐
//
//  Created by 颜晓卉 on 2016/11/22.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)

- (NSDateComponents *)intervalToDate:(NSDate *)date
{
    //日历对象
    NSCalendar * calendar = [NSCalendar currentCalendar];
    //想比较哪些元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //比较
    return [calendar components:unit fromDate:date];
}

- (NSDateComponents *)intervalToNow
{
    return [self intervalToDate:[NSDate date]];
}

- (BOOL)isThisYear
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}

- (BOOL)isToday
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents * selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year && nowCmps.month == nowCmps.month && nowCmps.day == selfCmps.day;
}

- (BOOL)isYestoday
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yy-MM-dd";  //获得只有年月日的日期格式
    
    //获得只有年月日的日期
    NSString * nowStr = [formatter stringFromDate:[NSDate date]];
    NSDate * nowDate = [formatter dateFromString:nowStr];
    
    NSString * selfStr = [formatter stringFromDate:self];
    NSDate * selfDate = [formatter dateFromString:selfStr];
    
    //比较
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * cmps = [calendar components:unit fromDate:nowDate toDate:selfDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

- (BOOL)isTomprrow
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yy-MM-dd";  //获得只有年月日的日期格式
    
    //获得只有年月日的日期
    NSString * nowStr = [formatter stringFromDate:[NSDate date]];
    NSDate * nowDate = [formatter dateFromString:nowStr];
    
    NSString * selfStr = [formatter stringFromDate:self];
    NSDate * selfDate = [formatter dateFromString:selfStr];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * cmps = [calendar components:unit fromDate:nowDate toDate:selfDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == -1;
}

@end
