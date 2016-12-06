//
//  collectionModel.h
//  recommend
//
//  Created by yuanjiangang on 2016/11/30.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface collectionModel : NSObject

@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *cover;
@property (assign,nonatomic)NSInteger danmaku;
@property (assign,nonatomic)NSInteger play;

-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key;
@end
