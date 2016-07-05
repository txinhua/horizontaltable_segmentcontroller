//
//  SignatureUtils.h
//  VCNetRequest
//
//  Created by VcaiTech on 16/4/13.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignatureUtils : NSObject

+(void)signWithAppkey:(NSString *)key andSecurity:(NSString *)security;

+(NSMutableDictionary *)packageRequestVerifyParameWithRequestParam:(NSDictionary *)reqParam andBodyStr:(NSString *)body;

+(NSMutableDictionary *)packageRequestVerifyParameWithRequestParam:(NSDictionary *)reqParam;

+(NSString *)generateAuthorizationStringFromToken:(NSString *)reqToken;

+(void)reSaveAccessToken:(NSString *)accToken;
+(void)clearAccessToken;
+(BOOL)AccessTokenIsNotNull;
@end
