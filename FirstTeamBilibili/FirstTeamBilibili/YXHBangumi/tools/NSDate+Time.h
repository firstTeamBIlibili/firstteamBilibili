//
//  NSDate+Time.h
//  24-百思不得姐
//
//  Created by 颜晓卉 on 2016/11/22.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Time)

- (NSDateComponents *)intervalToDate:(NSDate *)date;  //到date的时间间隔
- (NSDateComponents *)intervalToNow; //到现在的时间间隔

- (BOOL)isThisYear; //是否是今年
- (BOOL)isToday;  //是否是今天
- (BOOL)isYestoday; //是否是昨天
- (BOOL)isTomprrow;  //是否是明天
@end
