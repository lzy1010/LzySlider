//
//  LzySlider.m
//  TimeTest
//
//  Created by zzc-13 on 2018/4/23.
//  Copyright © 2018年 lzy. All rights reserved.
//

#import "LzySlider.h"
#import "UIImage+Helper.h"

@interface LzySlider()

@end

@implementation LzySlider

- (instancetype)init{
    self = [super init];
    if (self) {
        _isValid = true;
    }
    return self;
}

- (instancetype)initWithThumbView:(LzyThumbView *)thumbView{
    self = [super init];
    if (self) {
         _isValid = true;
        
        if (thumbView) {
            self.thumbView = thumbView;
        }
    }
    return self;
}

- (void)setThumbView:(LzyThumbView *)thumbView{
    _thumbView = thumbView;
    
    //初始化thumbView
    [self addSubview:thumbView];
    [self setThumbImage:[UIImage imageWithColor:[UIColor clearColor] size:thumbView.size] forState:UIControlStateNormal];
    [self setUpValue:self.value];
    [self setUpType:ThumbViewTypeNormal];
}


/**
 UISlider的所有subview都是在这里设置的frame
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self bringSubviewToFront:self.thumbView];
    _thumbView.frame = [self thumbRectForBounds:self.bounds trackRect:[self trackRectForBounds:self.bounds] value:self.value];
}


/**
 设置value的值，开始滑动滑块时默认调用
 
 @param value value
 */
- (void)setValue:(float)value{
    [super setValue:value];
    
    [self setUpValue:value];
}

#pragma mark UIControl delegate

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    BOOL begin = [super beginTrackingWithTouch:touch withEvent:event];
    if (!begin){
        return false;
    }
    
    if (self.sliderStart) {
        self.sliderStart(self);
    }
    
    [self setUpType:ThumbViewTypeHightlight];
    return true;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event{
    BOOL contin = [super continueTrackingWithTouch:touch withEvent:event];
    if (!contin) {
        return false;
    }
    
    if (self.sliderMove) {
        self.sliderMove(self);
    }
    
    [self setUpValue:self.value];
    return true;
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event{
    if (self.sliderEnd) {
        self.sliderEnd(self);
    }
    
    [self setUpType:ThumbViewTypeNormal];
}

#pragma mark 操作LzyThumbView
- (void)setUpType:(ThumbViewType)type{
    [self.thumbView setUpType:type];
}

- (void)setUpValue:(CGFloat)value{
    [self.thumbView setUpValue:value];
}


@end

@implementation LzyThumbView

- (instancetype)initWitSize:(CGSize)size{
    _size = size;
    self.userInteractionEnabled = false;
    
    return [self init];
}

- (void)setUpType:(ThumbViewType)type{
    _type = type;
}

- (void)setUpValue:(CGFloat)value{
    _value = value;
}

@end

