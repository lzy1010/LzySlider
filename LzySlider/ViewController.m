//
//  ViewController.m
//  LzySlider
//
//  Created by zzc-13 on 2018/4/23.
//  Copyright © 2018年 lzy. All rights reserved.
//

#import "ViewController.h"
#import "LzySlider.h"
#import "ThumbView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property (strong, nonatomic) LzySlider *slider;

@property (strong, nonatomic) ThumbView *thumbView;


@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.thumbView = [[ThumbView alloc] initWitSize:CGSizeMake(80, 22)];
    self.slider = ({
        LzySlider *slider = [[LzySlider alloc] initWithThumbView:self.thumbView];
        slider.maximumValue = 100;
        
        slider;
    });
    
    [self.view addSubview:self.slider];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
}



@end
