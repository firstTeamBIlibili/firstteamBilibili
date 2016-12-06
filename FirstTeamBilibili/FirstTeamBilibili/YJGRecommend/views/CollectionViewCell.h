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
@property (strong,nonatomic)UILabel *lable;


@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (strong, nonatomic) IBOutlet UILabel *leftlable;
@property (strong, nonatomic) IBOutlet UILabel *rightLable;
@property (strong, nonatomic) IBOutlet UIImageView *rightImage;
@property (strong, nonatomic) IBOutlet UILabel *lablele;
@property (strong,nonatomic)collectionModel *models;

@end
