//
//  YXHDetailModel.h
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/6.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHDetailModel : NSObject

@property(nonatomic,copy)NSString * bangumi_id;
@property(nonatomic,copy)NSString * bangumi_title; //标题
@property(nonatomic,copy)NSString * cover;  //图像
@property(nonatomic,copy)NSString * evaluate;  //简介
@property(nonatomic,copy)NSString * newest_ep_index;

@property(nonatomic,assign)NSInteger favorites;  //追番
@property(nonatomic,assign)BOOL is_finish;  //是否完结
@property(nonatomic,assign)NSInteger play_count;  //播放次数
@property(nonatomic,assign)NSInteger weekday;  //更新日期

@property(nonatomic,strong)NSArray * tags;
@property(nonatomic,strong)NSArray * episodes;

@end
