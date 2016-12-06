//
//  LiveModel.h
//  Project3
//
//  Created by wyzc03 on 16/11/30.
//  Copyright © 2016年 wyzc03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveModel : NSObject
//cell左下角标题
@property (nonatomic,copy) NSString * name;
//cell中间标题
@property (nonatomic,copy) NSString * title;
//cell图片
@property (nonatomic,copy) NSString * src;
//直播的区域分类
@property (nonatomic,copy) NSString * area;
//当前在线人数
@property (nonatomic,assign) NSInteger online;
//直播房间号
@property (nonatomic,assign) NSInteger room_id;
@end
