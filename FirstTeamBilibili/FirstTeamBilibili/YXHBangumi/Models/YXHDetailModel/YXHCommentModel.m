//
//  YXHCommentModel.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/7.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHCommentModel.h"

@implementation YXHCommentModel

- (CGFloat)cellHeight
{
    NSString * str = self.content[@"message"];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(WIDTH - 70, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    CGFloat height = rect.size.height + 50 + 15;
    return height;
}


@end
