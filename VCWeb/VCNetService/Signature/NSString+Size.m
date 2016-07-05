//
//  NSString+Size.m
//  chandiao
//
//  Created by VcaiTec on 15/11/10.
//  Copyright © 2015年 Tang guifu. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [self sizeWithAttributes:attributes];
    }
    else
    {
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        textSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(size.width, CGFLOAT_MAX) lineBreakMode:lineBreakMode];
#else
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
#endif
    }
    return textSize;
}
@end
