//
//  KeyChainStore.h
//  VCWeb
//
//  Created by VcaiTech on 16/6/29.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject
//存
+ (void)save:(NSString *)service data:(id)data ;
//取
+ (id)load:(NSString *)service;
//删
+ (void)deleteKeyData:(NSString *)service;

@end
