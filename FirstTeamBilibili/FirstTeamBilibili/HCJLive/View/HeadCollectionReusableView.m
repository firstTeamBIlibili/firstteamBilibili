//
//  HeadCollectionReusableView.m
//  Project3
//
//  Created by wyzc03 on 16/11/30.
//  Copyright © 2016年 wyzc03. All rights reserved.
//

#import "HeadCollectionReusableView.h"
#import "DetialLiveViewController.h"
#import "HCJLiveViewController.h"
@interface HeadCollectionReusableView ()

@end

@implementation HeadCollectionReusableView
- (IBAction)moreButtonAction:(UIButton *)sender {
    
    
    
    
    DetialLiveViewController * detialVC = [[DetialLiveViewController alloc] init];
    
    detialVC.dataArr = self.modelArr;
    
    HCJLiveViewController * liveVC = (HCJLiveViewController *)self.nextResponder.nextResponder.nextResponder;
    
    [liveVC.navigationController pushViewController:detialVC animated:YES];
        
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
