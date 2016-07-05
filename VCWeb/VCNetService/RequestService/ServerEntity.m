//
//  ServerEntity.m
//  WSFSZAss
//
//  Created by VcaiTech on 16/4/19.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "ServerEntity.h"

@implementation ServerEntity

-(instancetype)initWithMethod:(NSString *)method andUrl:(NSString *)url{
    self =  [super init];
    if (self) {
        self.requestMethod = method;
#if DEBUG
        self.serverUrl = [NSString stringWithFormat:@"http://192.168.1.45:8086/szass-api%@",url];
#else
         self.serverUrl = [NSString stringWithFormat:@"http://sz.ass.vcainfo.com/szass-api%@",url];
#endif
    }
    return self;
}

@end
