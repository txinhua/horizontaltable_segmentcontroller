//
//  SignatureUtils.m
//  VCNetRequest
//
//  Created by VcaiTech on 16/4/13.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "SignatureUtils.h"
#import "NSDate+JavaTimeStampToDate.h"
#import "NSString+VCSHA1.h"
#import "NSMutableDictionary+ConvertShaToken.h"
#import "NSString+VCBase64.h"


#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

static NSString *vcnAppSecrect = nil;
static NSString *vcnAppKey = nil;
static NSString *vcnAccessToken = nil;

@implementation SignatureUtils

+(void)clearAccessToken{
    vcnAccessToken = nil;
}

+(BOOL)AccessTokenIsNotNull{
    return !IsStrEmpty(vcnAccessToken);
}

+(void)reSaveAccessToken:(NSString *)accToken{
    
    @try {
        assert(accToken);
        vcnAccessToken = [accToken copy];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
}

+(void)signWithAppkey:(NSString *)key andSecurity:(NSString *)security{
    @try {
        assert(key);
        vcnAppKey = [key copy];
        assert(security);
        vcnAppSecrect = [security copy];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
}

+(NSString *)getRandomString
{
    NSString *motherStr = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int  locLenth = [[NSNumber numberWithInteger:motherStr.length-1] intValue];
    NSMutableString *rnStr =[NSMutableString string];
    for (int i = 4; i > 0; i--) {
        
        int index = [self getRandomNumber:0 to:locLenth];
        [rnStr appendString:[motherStr substringWithRange:NSMakeRange(index, 1)]];
    }
    return rnStr;
}


+(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1)));
}

+(NSMutableDictionary *)packageRequestVerifyParameWithRequestParam:(NSDictionary *)reqParam andBodyStr:(NSString *)body{
    @try {
        assert(reqParam);
        assert(body);
        
        NSMutableDictionary *rvP =[NSMutableDictionary dictionaryWithDictionary:reqParam];
        
        NSString *nonce = [self getRandomString];
        
        NSString *timpStamp = [NSString stringWithFormat:@"%.0f",[NSDate timestampWithHM]];
        [rvP setObject:nonce forKey:@"nonce"];
        [rvP setObject:timpStamp forKey:@"timestamp"];
        NSMutableString *formateStr = [rvP convertKeysValuesWithSortToString];
        
        if (formateStr) {
            [formateStr appendString:body];
            assert(vcnAppSecrect);
            [formateStr appendString:vcnAppSecrect];
            NSString *sha1Str = [formateStr VCSHA1];
            IsStrEmpty(sha1Str)?nil:
            [rvP setObject:sha1Str forKey:@"token"];
        }
        if (vcnAccessToken) {
            [rvP setObject:vcnAccessToken forKey:@"Ws-Access-Token"];
        }
        return rvP;
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    }
    
}

+(NSMutableDictionary *)packageRequestVerifyParameWithRequestParam:(NSDictionary *)reqParam{
    
    @try {
        assert(reqParam);
        
        NSMutableDictionary *rvP =[NSMutableDictionary dictionaryWithDictionary:reqParam];
        
        NSString *nonce = [self getRandomString];
        
        NSString *timpStamp = [NSString stringWithFormat:@"%.0f",[NSDate timestampWithHM]];
        [rvP setObject:nonce forKey:@"nonce"];
        [rvP setObject:timpStamp forKey:@"timestamp"];
        NSMutableString *formateStr = [rvP convertKeysValuesWithSortToString];
        
        if (formateStr) {
            assert(vcnAppSecrect);
            [formateStr appendString:vcnAppSecrect];
            NSString *sha1Str = [formateStr VCSHA1];
            IsStrEmpty(sha1Str)?nil:
            [rvP setObject:sha1Str forKey:@"token"];
        }
        if (vcnAccessToken) {
            [rvP setObject:vcnAccessToken forKey:@"Ws-Access-Token"];
        }
        return rvP;
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    }
    
}


+(NSString *)generateAuthorizationStringFromToken:(NSString *)reqToken{
    
    @try {
        assert(vcnAppKey);
        assert(reqToken);
        NSString *auth = [NSString stringWithFormat:@"%@:%@",vcnAppKey,reqToken];
        return [auth vcBase64Encode];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    }
    
}




@end
