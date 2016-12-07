//
//  YXHCommentMember.h
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/7.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHCommentMember : NSObject
@property(nonatomic,copy)NSString * uname; //评论用户名
@property(nonatomic,copy)NSString * avatar;
@property(nonatomic,copy)NSDictionary * level_info;

@end
