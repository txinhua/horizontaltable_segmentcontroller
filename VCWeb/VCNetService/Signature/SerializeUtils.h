//
//  SerializeUtils.h
//  AliOSS
//
//  Created by VcaiTech on 16/3/16.
//  Copyright © 2016年 唐桂富. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key);

extern NSURL* EncodeURLFromDic(NSDictionary *dic, NSString *key);

extern NSNumber* EncodeNumberFromDic(NSDictionary *dic, NSString *key);

extern NSDictionary *EncodeDicFromDic(NSDictionary *dic, NSString *key);

extern NSArray      *EncodeArrayFromDic(NSDictionary *dic, NSString *key);

extern NSArray      *EncodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic));

extern NSString *ReadLocalizedStringForKey(NSString *key,NSString *tableName);

extern id EncodeObjectFromDic(NSDictionary *dic, NSString *key);
