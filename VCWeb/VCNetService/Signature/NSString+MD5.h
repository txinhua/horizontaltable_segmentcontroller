//
//  NSString+MD5Encrypt.h
//  Smile
//
//  Created by tangguifu on 14-9-22.
//  Copyright (c) 2014年 Tang guifu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

-(NSString *)md5Encrypt;

@end
