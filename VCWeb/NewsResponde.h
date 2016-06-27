//
//  NewsResponde.h
//  VCWeb
//
//  Created by VcaiTech on 16/6/27.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsResponde : NSObject
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,assign)NSInteger totalPage;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,retain)NSMutableArray *data;
@end
