//
//  YXHTimeListModel.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/8.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHTimeListModel.h"

@implementation YXHTimeListModel
- (void)setPub_date:(NSString *)pub_date
{
    
    _pub_date = pub_date;
    
    //获取模型中发布日期距今天是第几天
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yy-MM-dd"];
    
    NSDate * pubDate = [fmt dateFromString:pub_date];
    NSDate * nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit  unit = NSCalendarUnitDay;
    
    NSDateComponents * cmps = [calendar components:unit fromDate:nowDate toDate:pubDate options:0];
    self.cmpDay = cmps.day;
    
    switch (cmps.day) {
        case -2:
            self.pubDate = @"前天";
            break;
        case -1:
            self.pubDate = @"昨天";
            break;
        case 0:
            self.pubDate = @"今天";
            break;
            
        default:
            self.pubDate = [pub_date substringFromIndex:5];
            break;
    }
    
    
    //根据发布日期计算是周几
    NSInteger week = [calendar component:NSCalendarUnitWeekday fromDate:pubDate];
    self.weekIndex = week;
    //NSLog(@"%ld",week);
    switch (week) {
        case 1:
            self.weekday = @"周日";
            break;
        case 2:
            self.weekday = @"周一";
            break;
        case 3:
            self.weekday = @"周二";
            break;
        case 4:
            self.weekday = @"周三";
            break;
        case 5:
            self.weekday = @"周四";
            break;
        case 6:
            self.weekday = @"周五";
            break;
        case 7:
            self.weekday = @"周六";
            break;
            
        default:
            break;
    }
}

@end
