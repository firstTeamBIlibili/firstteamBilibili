//
//  WDGServerValue.h
//  WilddogSync
//
//  Created by junpengwang on 16/9/8.
//  Copyright © 2016年 wilddog. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

/**
 *  用于写入 Wilddog Sync 时间戳
 */
@interface WDGServerValue : NSObject
/**
 * 可以作为一个值(value)或者优先级(priority)写入 Wilddog Sync 中，写入的字典数据会由 Wilddog Sync 自动转换为时间戳形式的数据
 * @return 返回一个载有 [".sv":"timestamp"] 的字典
 */
+ (NSDictionary *)timestamp;

@end


NS_ASSUME_NONNULL_END


