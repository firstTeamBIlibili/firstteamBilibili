//
//  LiveCollectionViewCell.h
//  Project3
//
//  Created by wyzc03 on 16/11/30.
//  Copyright © 2016年 wyzc03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"
@interface LiveCollectionViewCell : UICollectionViewCell
//是否显示区域标签
@property (nonatomic,assign) BOOL area;
@property (nonatomic,strong) LiveModel * model;
@end
