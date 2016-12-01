//
//  YXHRecommendModel.m
//  bangumi
//
//  Created by 颜晓卉 on 2016/11/30.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHRecommendModel.h"

@implementation YXHRecommendModel
+(void)load
{
    [YXHRecommendModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
}

- (CGFloat)itemHeight
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 2 * 10;
    CGFloat descHeight = [self.desc boundingRectWithSize:CGSizeMake(width, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    return 100 + 30 + descHeight;
    
}
@end
