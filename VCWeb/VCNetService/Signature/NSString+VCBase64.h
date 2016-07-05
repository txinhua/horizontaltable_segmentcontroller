//
//  NSString+VCBase64.h
//  VCNetRequest
//
//  Created by VcaiTech on 16/4/14.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VCBase64)
-(NSString *)vcBase64Encode;
-(NSString *)vcBase64Decode;
@end
