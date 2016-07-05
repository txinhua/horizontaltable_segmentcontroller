//
//  UUID.m
//  VCWeb
//
//  Created by VcaiTech on 16/6/29.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "UUID.h"
#import "KeyChainStore.h"

@implementation UUID

+(NSString *)getUUID
{
    
    NSString *keyUUID = [[[NSBundle mainBundle]bundleIdentifier]stringByAppendingString:@".userid"];
    NSString * strUUID = (NSString *)[KeyChainStore load:keyUUID];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [KeyChainStore save:keyUUID data:strUUID];
        
    }
    return strUUID;
}
@end
