//
//  YXHTimeListModel.h
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/8.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHTimeListModel : NSObject

@property(nonatomic,copy)NSString * cover;
@property(nonatomic,copy)NSString * date;  //时间戳
@property(nonatomic,copy)NSString * ep_id;
@property(nonatomic,copy)NSString * ep_index;
@property(nonatomic,copy)NSString * ontime;
@property(nonatomic,copy)NSString * pub_date; //发布日期,只有年月日
@property(nonatomic,copy)NSString * title;

@property(nonatomic,assign)NSInteger weekIndex;  //一周的第几天
@property(nonatomic,copy)NSString * weekday;  //周几
@property(nonatomic,assign)NSInteger cmpDay;

@property(nonatomic,copy)NSString * pubDate; //格式化后的发布日期

@end
