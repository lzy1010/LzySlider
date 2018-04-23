//
//  ThumbView.m
//  TimeTest
//
//  Created by zzc-13 on 2018/4/13.
//  Copyright © 2018年 lzy. All rights reserved.
//

#import "ThumbView.h"
#import <Masonry/Masonry.h>
#import "UIColor+HexString.h"
#import "TriangleView.h"

@interface ThumbView()

@property (strong, nonatomic) UILabel *contentLab;

@property (strong, nonatomic) UILabel *popUpLabel;
@property (strong, nonatomic) TriangleView *triagleView;

@end

@implementation ThumbView

- (instancetype)init{
    if ([super init]) {
        self.contentLab = ({
            UILabel *label = [[UILabel alloc] init];
            label.layer.cornerRadius = 11;
            label.layer.masksToBounds = true;
            label.layer.borderColor = [UIColor blueColor].CGColor;
            label.layer.borderWidth = 1;
            
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13];
            label;
        });
        [self addSubview:self.contentLab];
        
        
        self.popUpLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor colorWithHexString:@"#164AB0"];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
            label.font = [UIFont systemFontOfSize:14];
            
            label.layer.shadowOffset = CGSizeMake(0, -1);
            label.layer.shadowColor = [UIColor colorWithHexString:@"#000000"].CGColor;
            label.layer.shadowOpacity = 0.22;
            label.layer.shadowRadius = 3;
            
            label;
        });
        self.popUpLabel.hidden = true;
        [self addSubview:self.popUpLabel];
        
        [self.popUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(37);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-33.5);
        }];
        
        self.triagleView = ({
            TriangleView *view = [[TriangleView alloc] initWithColor:[UIColor colorWithHexString:@"#164AB0"] style:triangleViewIsoscelesBottom];
            
            view.layer.shadowOffset = CGSizeMake(0, -1);
            view.layer.shadowColor = [UIColor colorWithHexString:@"#000000"].CGColor;
            view.layer.shadowOpacity = 0.22;
            view.layer.shadowRadius = 3;
            
            view;
        });
        self.triagleView.hidden = true;
        [self addSubview:self.triagleView];
        
        [_triagleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(8.5);
            make.height.mas_equalTo(4.5);
            make.top.equalTo(self.popUpLabel.mas_bottom);
            make.centerX.mas_equalTo(0);
        }];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _contentLab.frame = self.bounds;
}

#pragma mark super method 必须实现
- (void)setUpValue:(CGFloat)value{
    [super setUpValue:value];
    
    NSString *text = [NSString stringWithFormat:@"%ld",lroundf(value)];
    
    _contentLab.text = text;
    _popUpLabel.text = text;
}

- (void)setUpType:(ThumbViewType)type{
    [super setUpType:type];
    
    NSString *bgColor = @"#FFFFFF";
    NSString *borderColor = @"#1243A8";
    NSString *textColor = @"#164AB0";
    CGFloat alpha = 1;
    BOOL popViewHidden = true;
    
    switch (type) {
        case ThumbViewTypeNormal:
            bgColor = @"#FFFFFF";
            borderColor = @"#1243A8";
            textColor = @"#164AB0";
            alpha = 1;
            popViewHidden = true;
            break;
        case ThumbViewTypeHightlight:
            bgColor = @"#164AB0";
            borderColor = @"#1243A8";
            textColor = @"#FFFFFF";
            alpha = 1;
            popViewHidden = false;
            break;
//        case ThumbViewTypeInvalid:
//            bgColor = @"#FFFFFF";
//            borderColor = @"#164AB0";
//            textColor = @"#164AB0";
//            alpha = 0.4;
//            popViewHidden = true;
//            break;
//        case ThumbViewTypeInvalidHightlight:
//            bgColor = @"#164AB0";
//            borderColor = @"#CCCCCC";
//            textColor = @"#FFFFFF";
//            alpha = 0.4;
//            popViewHidden = false;
//            break;
        default:
            break;
    }
    
    self.alpha = alpha;
    _contentLab.backgroundColor = [UIColor colorWithHexString:bgColor];
    _contentLab.layer.borderColor = [UIColor colorWithHexString:borderColor].CGColor;
    _contentLab.textColor = [UIColor colorWithHexString:textColor];
    _popUpLabel.hidden = popViewHidden;
    _triagleView.hidden = popViewHidden;
}

@end
