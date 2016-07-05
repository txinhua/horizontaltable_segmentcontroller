//
//  NSDate+JavaTimeStampToDate.m
//  IconFontDemo
//
//  Created by VcaiTec on 15/11/23.
//  Copyright © 2015年 alimama. All rights reserved.
//

#import "NSDate+JavaTimeStampToDate.h"

@implementation NSDate (JavaTimeStampToDate)

+(nullable NSDate *)DateFromJTimeStamp:(nonnull NSNumber *)timeStamp{
    
    double timestampval =  [timeStamp doubleValue]/1000.0;
    NSTimeInterval timestamp = (NSTimeInterval)timestampval;
    NSDate *updatetimestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return updatetimestamp;
}

-(nullable NSString *)convertToStringWithTimeZone:(nullable NSTimeZone *)timeZone andDateFormat:(nonnull NSString *)dateFormat{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = timeZone?timeZone:[NSTimeZone localTimeZone];
    df.dateFormat = dateFormat;//@"yyyy-MM-dd HH:mm:ss";
    return [df stringFromDate: self];
}

+(NSTimeInterval)timestampWithHM{
    NSDate *currentDate = [NSDate date];
    return currentDate.timeIntervalSince1970*1000;
}

@end
