//
//  NSMutableDictionary+ConvertShaToken.m
//  CDClient
//
//  Created by VcaiTec on 15/12/9.
//  Copyright © 2015年 Tang guifu. All rights reserved.
//

#import "NSMutableDictionary+ConvertShaToken.h"
#import "SerializeUtils.h"
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
@implementation NSMutableDictionary (ConvertShaToken)

-(NSMutableString *)convertKeysValuesWithSortToString{
    NSArray *unOrderkeys = self.allKeys;
    __block NSMutableString *unShaStr;
    if (unOrderkeys)
    {
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObject:descriptor];
        NSArray *resultArray = [unOrderkeys sortedArrayUsingDescriptors:descriptors];
        unShaStr = [NSMutableString string];
        
        [resultArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *valueStr = EncodeStringFromDic(self, key);
            if (!IsStrEmpty(valueStr)) {
                [unShaStr appendString:key];
                [unShaStr appendString:@"="];
                [unShaStr appendString:valueStr];
                if (idx < resultArray.count-1) {
                    [unShaStr appendString:@"&"];
                }
            }else{
                [self removeObjectForKey:key];
            }
        }];
        
        if (unShaStr.length>0) {

        }else {
            unShaStr =  nil;
        }
        
    }else{
       unShaStr =  nil;
    }
    return unShaStr;
    
}

@end
