//
//  YXHNewBangumiModel.h
//  bangumi
//
//  Created by 颜晓卉 on 2016/11/30.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHNewBangumiModel : NSObject

@property(nonatomic,copy)NSString * cover;
@property(nonatomic,copy)NSString * title;

@property(nonatomic,assign)NSInteger favourites;
@property(nonatomic,assign)BOOL is_finish;
@property(nonatomic,assign)BOOL is_started;
@property(nonatomic,copy)NSString * last_time;
@property(nonatomic,copy)NSString * newest_ep_index;
@property(nonatomic,copy)NSString * pub_time;
@property(nonatomic,copy)NSString * season_id;
@property(nonatomic,copy)NSString * season_status;
@property(nonatomic,assign)NSInteger watching_count;


@end
