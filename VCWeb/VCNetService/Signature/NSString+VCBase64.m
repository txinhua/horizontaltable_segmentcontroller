//
//  NSString+VCBase64.m
//  VCNetRequest
//
//  Created by VcaiTech on 16/4/14.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "NSString+VCBase64.h"
#import "NSData+Base64.h"

@implementation NSString (VCBase64)

-(NSString *)vcBase64Encode{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}

-(NSString *)vcBase64Decode{
    
     return [NSString stringWithBase64EncodedString:self];
}

+ (NSString *)stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data)
    {
        NSString *result = [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
#if !__has_feature(objc_arc)
        [result autorelease];
#endif
        
        return result;
    }
    return nil;
}

@end
