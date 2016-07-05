//
//  NSDate+JavaTimeStampToDate.h
//  IconFontDemo
//
//  Created by VcaiTec on 15/11/23.
//  Copyright © 2015年 alimama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JavaTimeStampToDate)

+(nullable NSDate *)DateFromJTimeStamp:(nonnull NSNumber *)timeStamp;

-(nullable NSString *)convertToStringWithTimeZone:(nullable NSTimeZone *)timeZone andDateFormat:(nonnull NSString *)dateFormat;

+(NSTimeInterval)timestampWithHM;

@end
