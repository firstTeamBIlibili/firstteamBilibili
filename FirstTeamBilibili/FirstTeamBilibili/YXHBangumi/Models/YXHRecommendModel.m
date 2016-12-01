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
@end
