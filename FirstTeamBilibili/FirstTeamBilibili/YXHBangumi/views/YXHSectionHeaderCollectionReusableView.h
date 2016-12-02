//
//  YXHSectionHeaderCollectionReusableView.h
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/2.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXHSectionHeaderCollectionReusableView : UICollectionReusableView
@property(nonatomic,copy)NSString * headerImageName;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)NSInteger sectionIndex;

@end
