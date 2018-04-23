//
//  UIColor+HexString.h
//  Zuzuche_Ios_New
//
//  Created by simon247 on 5/12/15.
//  Copyright (c) 2015 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alpha;

@end
