//
//  NewBangumiCollectionViewCell.h
//  bangumi
//
//  Created by 颜晓卉 on 2016/12/1.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXHNewBangumiModel.h"

@interface YXHNewBangumiCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)YXHNewBangumiModel * model;

@property(nonatomic,assign)CGFloat cellHeight;

@end
