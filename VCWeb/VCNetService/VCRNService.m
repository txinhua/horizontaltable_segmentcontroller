//
//  VCRNService.m
//  WSFSZAss
//
//  Created by VcaiTech on 16/4/27.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "VCRNService.h"
#import "SerializeUtils.h"

#define DeviceTokenKey  @"WSFSZASSDEVICETOKEN"
#define PUSHLOADBody    @"WSFSZASSPUSHBODY"
#define PARAME_TASK_ID  @"wsf_task_id"
//#define SHOW_DETAIL_NOTIFY @"wsf_saass_show_detail_notify"

@implementation VCRNService

+(void)decodeNotifyFormDictionary:(nonnull NSDictionary *)dic finishedBlock:(void (^ _Nullable)( NSString * _Nullable message))block{
    NSNumber *espId = EncodeNumberFromDic(dic, @"i");
    [[NSUserDefaults standardUserDefaults]setObject:espId forKey:PARAME_TASK_ID];
    if (block) {
        NSDictionary *alert =EncodeDicFromDic(EncodeDicFromDic(dic, @"aps"),@"alert");
        block(EncodeStringFromDic(alert, @"body"));
    }
}

+(void)saveDeviceToken:(NSString *)token{
    if (token) {
       [[NSUserDefaults standardUserDefaults]setObject:token forKey:DeviceTokenKey];
    }else{
       [[NSUserDefaults standardUserDefaults]removeObjectForKey:DeviceTokenKey];
    }
    
}
+(NSString *)getDeviceToken{
    return [[NSUserDefaults standardUserDefaults]objectForKey:DeviceTokenKey];
}


+(id)getPushBodyContent{
    return  [[NSUserDefaults standardUserDefaults]objectForKey:PUSHLOADBody];
}

+(void)savePushBodyContent:(id)content{
    [[NSUserDefaults standardUserDefaults]setObject:content forKey:PUSHLOADBody];
}

+(void)removePushBodyContent{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:PUSHLOADBody];
}


+(id)readTaskId{
    return [[NSUserDefaults standardUserDefaults]objectForKey:PARAME_TASK_ID];
}

+(void)removeTaskId{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:PARAME_TASK_ID];
}

+(void)showTaskDetailView{
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:SHOW_DETAIL_NOTIFY object:nil userInfo:@{SHOW_DETAIL_NOTIFY:[VCRNService readTaskId]}];
    
}

@end
