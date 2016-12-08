//
//  XIAOJIViewController.m
//  recommend
//
//  Created by yuanjiangang on 2016/12/8.
//  Copyright © 2016年 WYZC. All rights reserved.
//
#import "XIAOJIViewController.h"
@interface XIAOJIViewController ()
@property (strong,nonatomic)NSMutableArray *imagearray;


@end

@implementation XIAOJIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=self.view.bounds;
    button.alpha=10;
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(dainji) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:button];
}



-(void)dainji{
    self.title=@"愤怒的小鸟";

    _imagearray=[NSMutableArray array];
    NSArray *ar=@[@"q.tiff",@"w.tiff",@"e.tiff",@"r.tiff",@"t.tiff",@"y.tiff",@"u.tiff",@"i.tiff",@"o.tiff",@"p.tiff",@"a.tiff"];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:imageView];
    for (int i=0; i<ar.count; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",ar[i]]];
        [_imagearray addObject:image];
    }
    imageView.animationImages=_imagearray;
    imageView.animationDuration=0.3 * 11;
    imageView.animationRepeatCount=0;
    [imageView startAnimating];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
