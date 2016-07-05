//
//  VCNetRequestBaseService.m
//  VCNetRequest
//
//  Created by VcaiTech on 16/4/14.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "VCNetRequestBaseService.h"
#import "VCHttpClient.h"
#import "SignatureUtils.h"
#import "SerializeUtils.h"
#import "NSMutableDictionary+ConvertShaToken.h"

#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

#undef  NETWORKWWANUNABLE
#define NETWORKWWANUNABLE -20000

#undef  NETWORKUNABLE
#define NETWORKUNABLE -20001

#undef  NETWORKPARAMERROR
#define NETWORKPARAMERROR -10031

#undef  NETWORKRESPONSERROR
#define NETWORKRESPONSERROR -10030

#undef  NETWORKMETHODERROR
#define NETWORKMETHODERROR 405

//网络请求返回的基础类
@implementation ResponsedUnit
-(void)encodeFormDicTionary:(NSDictionary *)dic{
    self.sc = EncodeNumberFromDic(dic,@"sc");
    self.result =EncodeObjectFromDic(dic,@"result");
}
@end


@implementation VCNetRequestBaseService

-(void)requestDataFromServer:(NSString *)serverUrl withMethod:(NSString *)method Parame:(NSDictionary *)parame Body:(NSString *)body andCompletion:(NetResponseBlock)block{
    if (IsStrEmpty(body)) {
        [self requestDataFromServer:serverUrl withMethod:method Parame:parame andCompletion:block];
    }else{
        
        NSMutableDictionary *requestBody = [SignatureUtils packageRequestVerifyParameWithRequestParam:parame andBodyStr:body];
        
        serverUrl = [serverUrl stringByAppendingString:[self generateRequestLineFromDicTionary:requestBody]];
        [[VCHttpClient sharedClient]POST:serverUrl parameters:requestBody constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (!IsStrEmpty(body)) {
                NSData *jsonData = [body dataUsingEncoding:NSUTF8StringEncoding];
//                [formData appendBody:jsonData];
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (responseObject) {
                if (block) {
                    ResponsedUnit *unit = [[ResponsedUnit alloc]init];
                    [unit encodeFormDicTionary:responseObject];
                    block(unit,nil);
                }
            }else{
                if (block) {
                    
                    NSError *error =[NSError errorWithDomain:ReadLocalizedStringForKey(@"response error",@"VCNetLocalString") code:NETWORKRESPONSERROR userInfo:nil];
                    block(nil,error);
                }
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (block) {
                block(nil,error);
            }
            
        }];
    }
}

-(NSString *)generateRequestLineFromDicTionary:(NSDictionary *)dic{
    
    NSMutableDictionary *realDic =[NSMutableDictionary dictionaryWithDictionary:dic];
    [realDic removeObjectsForKeys:@[@"Ws-Access-Token",@"token"]];
    return [NSString stringWithFormat:@"?%@",[realDic convertKeysValuesWithSortToString]];
    
}

-(void)requestDataFromServer:(NSString *)serverUrl withMethod:(NSString *)method Parame:(NSDictionary *)parame andCompletion:(NetResponseBlock)block{
    
    [VCHttpClient getNetWorkTypeAndWorkStatuseWithBlock:^(BOOL workStatus, NetWorkType netWorkType) {
        if (workStatus) {
            
            NSMutableDictionary *requestBody = [SignatureUtils packageRequestVerifyParameWithRequestParam:parame];
            
            if (requestBody) {
                if ([method isEqualToString:@"POST"]) {
                    [[VCHttpClient sharedClient]POST:serverUrl parameters:requestBody progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        if (responseObject) {
                            
                            if (block) {
                                ResponsedUnit *unit = [[ResponsedUnit alloc]init];
                                [unit encodeFormDicTionary:responseObject];
                                block(unit,nil);
                            }
                            
                        }else{
                            if (block) {
                                
                                NSError *error =[NSError errorWithDomain:ReadLocalizedStringForKey(@"response error",@"VCNetLocalString") code:NETWORKRESPONSERROR userInfo:nil];
                                block(nil,error);
                            }
                            
                        }
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        if (block) {
                            
                            block(nil,error);
                            
                        }
                        
                    }];
                }else if ([method isEqualToString:@"GET"]){
                     [[VCHttpClient sharedClient]GET:serverUrl parameters:requestBody progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         if (requestBody) {
                             
                             if (block) {
                                 ResponsedUnit *unit = [[ResponsedUnit alloc]init];
                                 [unit encodeFormDicTionary:responseObject];
                                 block(unit,nil);
                             }
                             
                         }else{
                             if (block) {
                                 
                                 NSError *error =[NSError errorWithDomain:ReadLocalizedStringForKey(@"response error",@"VCNetLocalString") code:NETWORKRESPONSERROR userInfo:nil];
                                 block(nil,error);
                             }
                             
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         if (block) {
                             
                             block(nil,error);
                             
                         }
                         
                     }];
                }else{
                    if (block) {
                       NSError *error =[NSError errorWithDomain:ReadLocalizedStringForKey(@"request method error",@"VCNetLocalString") code:NETWORKMETHODERROR userInfo:nil];
                        block(nil,error);
                    }
                }
                
                
            }else{
                
                if (block) {
                    NSError *error =[NSError errorWithDomain:ReadLocalizedStringForKey(@"parame error",@"VCNetLocalString") code:NETWORKPARAMERROR userInfo:nil];
                    block(nil,error);
                }
                
            }
        }else{
            if (netWorkType==NetWorkType_WWAN) {
                
                if (block) {
                    NSError *error =[NSError errorWithDomain:ReadLocalizedStringForKey(@"cellular data Unavailable",@"VCNetLocalString") code:NETWORKWWANUNABLE userInfo:nil];
                    block(nil,error);
                }
                
            }else{
                
                if (block) {
                    NSError *error =[NSError errorWithDomain:ReadLocalizedStringForKey(@"no network",@"VCNetLocalString") code:NETWORKUNABLE userInfo:nil];
                    block(nil,error);
                }
                
            }
        }
        
    }];

}

@end
