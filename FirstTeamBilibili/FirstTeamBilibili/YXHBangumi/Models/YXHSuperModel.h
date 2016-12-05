//
//  YXHSuperModel.h
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHSuperModel : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * cover;
@property(nonatomic,copy)NSString * uri;
@property(nonatomic,copy)NSString * param;
@property(nonatomic,copy)NSString * GOTO;
@property(nonatomic,copy)NSString * name;

@property(nonatomic,assign)NSInteger play;
@property(nonatomic,assign)NSInteger danmaku;
@property(nonatomic,assign)NSInteger reply;
@property(nonatomic,assign)NSInteger favourite;

@end
