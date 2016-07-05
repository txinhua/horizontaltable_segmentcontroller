//
//  VCRNService.h
//  WSFSZAss
//
//  Created by VcaiTech on 16/4/27.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCRNService : NSObject
+(void)saveDeviceToken:(NSString *)token;
+(NSString *)getDeviceToken;
+(id)readTaskId;
+(void)removeTaskId;
+(id)getPushBodyContent;
+(void)savePushBodyContent:(id)content;
+(void)removePushBodyContent;
+(void)decodeNotifyFormDictionary:( NSDictionary *)dic finishedBlock:(void (^)( NSString *  message))block;
+(void)showTaskDetailView;
@end
