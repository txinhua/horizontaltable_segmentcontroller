//
//  VCWebView.m
//  VCWeb
//
//  Created by VcaiTech on 16/7/5.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "VCWebView.h"

@implementation VCWebView

-(instancetype)init{
    return [self initWithFrame:CGRectZero];
}



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor colorWithRed:64/255.0 green:67/255.0 blue:68/255.0 alpha:1.0];
        if (_domainLabel==nil) {
            _domainLabel =[[UILabel alloc]initWithFrame:CGRectZero];
            _domainLabel.alpha = 0;
            _domainLabel.backgroundColor = [UIColor clearColor];
            _domainLabel.textAlignment = NSTextAlignmentCenter;
            _domainLabel.font =[UIFont systemFontOfSize:14];
            _domainLabel.textColor =[UIColor colorWithRed:111/255.0 green:114/255.0 blue:120/255.0 alpha:1.0];
            [self insertSubview:_domainLabel belowSubview:self.scrollView];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [_domainLabel setFrame:CGRectMake(0, 20, rect.size.width, 20)];
}


@end
