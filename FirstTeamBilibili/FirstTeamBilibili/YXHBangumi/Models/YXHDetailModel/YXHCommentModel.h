//
//  YXHCommentModel.h
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/7.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXHCommentMember.h"

@interface YXHCommentModel : NSObject

@property(nonatomic,assign)NSInteger count;  //评论的评论数
@property(nonatomic,assign)NSInteger floor;  //评论所在楼数
@property(nonatomic,copy)NSString * ctime;  //评论发表时间戳
@property(nonatomic,assign)NSInteger  like;  //点赞数
@property(nonatomic,strong)NSDictionary * content; //评论内容

@property(nonatomic,strong)YXHCommentMember * member; //评论者


- (CGFloat)cellHeight;

@end
