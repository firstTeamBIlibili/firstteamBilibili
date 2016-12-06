//
//  YXHDetailepisode.h
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/6.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHDetailepisode : NSObject
@property(nonatomic,copy)NSString * av_id;
@property(nonatomic,copy)NSString * cover;
@property(nonatomic,copy)NSString * episode_id;
@property(nonatomic,copy)NSString * index;
@property(nonatomic,copy)NSString * index_title;
@property(nonatomic,assign)BOOL is_new;
@property(nonatomic,assign)NSString * update_time;

@end
