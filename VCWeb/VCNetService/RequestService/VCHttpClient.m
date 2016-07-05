//
//  VCHttpClient.m
//  VCNetRequest
//
//  Created by VcaiTech on 16/4/14.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "VCHttpClient.h"
#import "SignatureUtils.h"
#import "VCRNService.h"


#define	kNetworkTestAddress						@"www.baidu.com"

@implementation VCHttpClient



+ (instancetype)sharedClient {
    
    static dispatch_once_t pred;
    static VCHttpClient *whatever = nil;
    dispatch_once(&pred, ^{
        whatever = [[VCHttpClient alloc] init];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        whatever.securityPolicy = securityPolicy;
    });
    return whatever;

}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSError *serializationError = nil;
    [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
    NSString *accessToken = [parameters objectForKey:@"Ws-Access-Token"];
    if (accessToken) {
        [self.requestSerializer setValue:accessToken forHTTPHeaderField:@"Ws-Access-Token"];
        [parameters removeObjectForKey:@"Ws-Access-Token"];
    }else{
        [self.requestSerializer clearAccessTokenHeader];
    }
    
    NSString *token = [parameters objectForKey:@"token"];
    NSString *authourization = [SignatureUtils generateAuthorizationStringFromToken:token];
    if (authourization) {
        [self.requestSerializer setValue:authourization forHTTPHeaderField:@"Authorization"];
    }
    [parameters removeObjectForKey:@"token"];
    NSString *deviceId = [VCRNService getDeviceToken];
    if (deviceId) {
        [self.requestSerializer setValue:deviceId forHTTPHeaderField:@"Ws-Device-id"];
    }
    
    NSMutableURLRequest *request = [self.requestSerializer wsfmultipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}


- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    
    [self setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    NSString *accessToken = [parameters objectForKey:@"Ws-Access-Token"];
    if (accessToken) {
        [self.requestSerializer setValue:accessToken forHTTPHeaderField:@"Ws-Access-Token"];
        [parameters removeObjectForKey:@"Ws-Access-Token"];
    }else{
        [self.requestSerializer clearAccessTokenHeader];
    }
    
    NSString *token = [parameters objectForKey:@"token"];
    NSString *authourization = [SignatureUtils generateAuthorizationStringFromToken:token];
    if (authourization) {
        [self.requestSerializer setValue:authourization forHTTPHeaderField:@"Authorization"];
    }
    [parameters removeObjectForKey:@"token"];
    NSString *deviceId = [VCRNService getDeviceToken];
    if (deviceId) {
        [self.requestSerializer setValue:deviceId forHTTPHeaderField:@"Ws-Device-id"];
    }
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];
    
    return dataTask;
}


+ (BOOL)netWorkIsOk{
    
    BOOL bEnabled = FALSE;
    NSString *url = kNetworkTestAddress;
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (bEnabled) {
        
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
    }
    
    return bEnabled;
}

+(void)getNetWorkTypeAndWorkStatuseWithBlock:(void (^)(BOOL workStatus,  NetWorkType netWorkType))block{
    
    BOOL bEnabled = FALSE;
    NSString *url = kNetworkTestAddress;
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    
    NetWorkType retVal = NetWorkType_None;
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        retVal = NetWorkType_WIFI;
    }
    
    
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
         (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            retVal = NetWorkType_WIFI;
        }
    }else{
        if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
        {
            retVal = NetWorkType_WWAN;
        }
    }
    
    if (bEnabled) {
        
        BOOL flagsReachable = (flags & kSCNetworkFlagsReachable);
        BOOL connectionRequired = (flags & kSCNetworkFlagsConnectionRequired);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
    }
    
    block(bEnabled,retVal);
}


@end
