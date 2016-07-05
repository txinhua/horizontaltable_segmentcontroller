//
//  NSString+Size.h
//  chandiao
//
//  Created by VcaiTec on 15/11/10.
//  Copyright © 2015年 Tang guifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)
- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end
