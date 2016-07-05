//
//  ServerEntity.h
//  WSFSZAss
//
//  Created by VcaiTech on 16/4/19.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerEntity : NSObject
@property(nonatomic,retain)NSString *requestMethod;
@property(nonatomic,retain)NSString *serverUrl;
-(instancetype)initWithMethod:(NSString *)method andUrl:(NSString *)url;
@end
