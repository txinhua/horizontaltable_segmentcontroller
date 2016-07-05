//
//  VCNetRequestBaseService.h
//  VCNetRequest
//
//  Created by VcaiTech on 16/4/14.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerEntity.h"

typedef NS_ENUM(NSInteger, WSFLoginError) {
    WSFLoginErrorNone          = 0,
    WSFLoginErrorUserName      = 1,    // usernameError
    WSFLoginErrorPassWord      = 2
} NS_ENUM_AVAILABLE_IOS(6_0);


typedef NS_ENUM(NSInteger, WSFRESPONSECODE) {
    WSFRESPONSECODE_SUCCESS    = 0,
    WSFRESPONSEACCESS_TOKEN_INVALID = 20003,
    WSFRESPONSECODE_TOKEN_CHEKC_FAIL    = 30003,
    WSFRESPONSECODE_INVALID_PHONE_NUMBER       =30006,
    WSFRESPONSECODE_INVALID_FIELD_VALUE = 30008,
    WSFRESPONSECODE_WEB_AUTHORIZATION_INVALID = 30023,
    WSFRESPONSECODE_NO_WEB_AUTHORIZATION = 30024,
    WSFRESPONSECODE_USER_IS_REGISTERED      = 30025,
    WSFRESPONSECODE_USER_NOT_ACTIVE     = 30026
    
} NS_ENUM_AVAILABLE_IOS(6_0);


@interface ResponsedUnit : NSObject

@property(nonatomic,retain)NSNumber *sc;
@property(nonatomic,retain)id result;

-(void)encodeFormDicTionary:(NSDictionary *)dic;

@end

typedef void (^NetResponseBlock)(ResponsedUnit *responseUnit, NSError *error);

@interface VCNetRequestBaseService : NSObject

-(void)requestDataFromServer:(NSString *)serverUrl withMethod:(NSString *)method Parame:(NSDictionary *)parame Body:(NSString *)body andCompletion:(NetResponseBlock)block;

-(void)requestDataFromServer:(NSString *)serverUrl withMethod:(NSString *)method Parame:(NSDictionary *)parame andCompletion:(NetResponseBlock)block;

@end
