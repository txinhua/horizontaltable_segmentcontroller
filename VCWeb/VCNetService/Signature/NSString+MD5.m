//
//  NSString+MD5Encrypt.h
//  Smile
//
//  Created by tangguifu on 14-9-22.
//  Copyright (c) 2014年 Tang guifu. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)

-(NSString *)md5Encrypt {
    
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    NSNumber *dataLength = [NSNumber numberWithChar:strlen(cStr)];
    CC_MD5( cStr, [dataLength unsignedIntValue], result );
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
