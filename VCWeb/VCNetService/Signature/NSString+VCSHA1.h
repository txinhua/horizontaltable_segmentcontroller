//
//  NSString+NSString_SHA1.h
//  PhoneMeeting
//
//  Created by tangguifu on 14-9-22.
//  Copyright (c) 2014年 Tang guifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (VCSHA1)
-(NSString *)VCSHA1;
@end
