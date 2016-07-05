//
//  SerializeUtils.m
//  AliOSS
//
//  Created by VcaiTech on 16/3/16.
//  Copyright © 2016年 唐桂富. All rights reserved.
//

#import "SerializeUtils.h"


NSURL* EncodeURLFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    
    if ([temp isKindOfClass:[NSString class]])
    {
        return [NSURL URLWithString:temp];
    }
    
    else if ([temp isKindOfClass:[NSURL class]]){
        
        return  temp;
    }
    return nil;
}

NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return temp;
    }
    
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return [temp stringValue];
    }else if ([temp isKindOfClass:[NSURL class]]){
        
        return  [temp absoluteString];
    }
    
    return nil;
}

NSNumber* EncodeNumberFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return [NSNumber numberWithDouble:[temp doubleValue]];
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return temp;
    }
    return nil;
}

NSDictionary *EncodeDicFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSDictionary class]])
    {
        return temp;
    }
    return nil;
}

NSArray      *EncodeArrayFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSArray class]])
    {
        return temp;
    }
    return nil;
}

NSArray      *EncodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic))
{
    NSArray *tempList = EncodeArrayFromDic(dic, key);
    if ([tempList count])
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[tempList count]];
        for (NSDictionary *item in tempList)
        {
            id dto = parseBlock(item);
            if (dto) {
                [array addObject:dto];
            }
        }
        return array;
    }
    return nil;
}

NSString *ReadLocalizedStringForKey(NSString *key,NSString *tableName){
    return  [[NSBundle mainBundle]localizedStringForKey:key value:key table:tableName];
}

id EncodeObjectFromDic(NSDictionary *dic, NSString *key){
    
    id temp = [dic objectForKey:key];
    return temp;
}


