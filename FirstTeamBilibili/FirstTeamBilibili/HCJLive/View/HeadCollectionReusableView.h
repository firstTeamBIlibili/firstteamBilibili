//
//  HeadCollectionReusableView.h
//  Project3
//
//  Created by wyzc03 on 16/11/30.
//  Copyright © 2016年 wyzc03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"
@interface HeadCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (nonatomic,strong) NSArray * modelArr;
@property (nonatomic,strong) NSIndexPath  * indexPath;
@end
