//
//  YXHCommentModel.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/7.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHCommentModel.h"
#import "NSDate+Time.h"

@implementation YXHCommentModel

- (CGFloat)cellHeight
{
    NSString * str = self.content[@"message"];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(WIDTH - 70, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    CGFloat height = rect.size.height + 50 + 15;
    return height;
}

- (NSString *)ctime
{
    //将时间戳转换成日期格式
    long long int stampTime = (long long int)[_ctime integerValue];
    NSDate * date1 = [NSDate dateWithTimeIntervalSince1970:stampTime];
    
    //将日期转换成本地日期
    NSDate * date2 = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:date1];
    
    //时间格式
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yy-MM-dd HH:mm:ss";
    
    NSDate * date = [fmt dateFromString:[fmt stringFromDate:date2]];
    
    //NSLog(@"%@",date);
    
    //比较发帖时间和当前时间的时间差
    NSDateComponents * cmps = [date intervalToNow];
    
    if (date.isThisYear) //今年
    {
        if (date.isToday) //今天
        {
            if (cmps.hour >= 1)
            {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1)
            {
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else
            {
                return @"刚刚";
            }
        }else if (date.isYestoday)  //昨天
        {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:date];
        }else  //今年的其他时间
        {
            fmt.dateFormat = @"MM-dd";
            return [fmt stringFromDate:date];
        }
    }else  //不是今年
    {
        return [fmt stringFromDate:date];
    }
    
}
@end
