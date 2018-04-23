//
//  LzySlider.h
//  TimeTest
//
//  Created by zzc-13 on 2018/4/23.
//  Copyright © 2018年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ThumbViewType) {
    ThumbViewTypeNormal,
    ThumbViewTypeHightlight
};

@interface LzyThumbView : UIView

@property (assign, nonatomic, readonly) ThumbViewType type;

@property (assign, nonatomic, readonly) CGFloat value;

/**
 thumbSize
 */
@property (assign, nonatomic) CGSize size;

- (instancetype)initWitSize:(CGSize)size;

//需要重写的方法

- (void)setUpValue:(CGFloat)value;

- (void)setUpType:(ThumbViewType)type;

@end

@interface LzySlider : UISlider

- (instancetype)initWithThumbView:(LzyThumbView *)thumbView;

@property (strong, nonatomic) LzyThumbView *thumbView;

@property (assign, nonatomic) BOOL isValid;

@property (copy, nonatomic) void(^sliderStart)(UISlider *slider);
@property (copy, nonatomic) void(^sliderMove)(UISlider *slider);
@property (copy, nonatomic) void(^sliderEnd)(UISlider *slider);

@end

