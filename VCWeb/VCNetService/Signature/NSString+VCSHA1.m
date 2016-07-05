//
//  NSString+NSString_SHA1.m
//  PhoneMeeting
//
//  Created by tangguifu on 14-9-22.
//  Copyright (c) 2014年 Tang guifu. All rights reserved.
//

#import "NSString+VCSHA1.h"

@implementation NSString (VCSHA1)

-(NSString *)VCSHA1{
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
    
}

@end
