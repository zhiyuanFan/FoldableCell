//
//  UIColor+IFMHexColor.h
//  ifilmo2
//
//  Created by ifilmo on 5/23/16.
//  Copyright © 2016 ifilmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (IFMHexColor)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
