//
//  CollectionViewCell.h
//  recommend
//
//  Created by yuanjiangang on 2016/11/30.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "collectionModel.h"
@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightimageView;
@property (strong,nonatomic)UILabel *lable;
@property (weak, nonatomic) IBOutlet UIImageView *leftimageView;
@property (strong, nonatomic) IBOutlet UILabel *lablele;
@property (strong,nonatomic)collectionModel *models;

@end
