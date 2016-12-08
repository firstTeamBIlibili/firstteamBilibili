//
//  YXHTimeListSectionHeaderCollectionReusableView.h
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/8.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXHTimeListSectionHeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *weekday;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
