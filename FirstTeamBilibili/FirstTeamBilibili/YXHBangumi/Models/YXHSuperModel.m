//
//  YXHSuperModel.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHSuperModel.h"

@implementation YXHSuperModel
+(void)load
{
    [YXHSuperModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"GOTO":@"goto"};
    }];
}
@end
