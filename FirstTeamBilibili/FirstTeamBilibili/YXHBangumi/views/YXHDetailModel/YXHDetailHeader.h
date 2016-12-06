//
//  YXHDetailHeader.h
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/6.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXHDetailModel.h"

@interface YXHDetailHeader : UIView

@property(nonatomic,strong)YXHDetailModel * model;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
