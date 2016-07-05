//
//  VCWebBrowserController.m
//  VCWeb
//
//  Created by VcaiTech on 16/6/29.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "VCWebBrowserController.h"
#import <NJKWebViewProgress/NJKWebViewProgress.h>
#import <NJKWebViewProgress/NJKWebViewProgressView.h>
#import "VCWebView.h"

@interface VCWebBrowserController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
//    UILabel *_domainName;
    VCWebView *_vcWebView;
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
}
@end

@implementation VCWebBrowserController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    CGRect navBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0,
                                 navBounds.size.height - 2,
                                 navBounds.size.width,
                                 2);
    
    if (_vcWebView==nil) {
        _vcWebView = [[VCWebView alloc]initWithFrame:CGRectMake(0, 20+navBounds.origin.y+navBounds.size.height, self.view.frame.size.width, self.view.frame.size.height-(navBounds.origin.y+navBounds.size.height+20))];
        [self.view addSubview:_vcWebView];
    }
    
//    if (_domainName==nil) {
//        _domainName =[[UILabel alloc]initWithFrame:CGRectMake(0, 20, _vcWebView.frame.size.width, 20)];
//        _domainName.alpha = 0;
//        _domainName.backgroundColor = [UIColor clearColor];
//        _domainName.textAlignment = NSTextAlignmentCenter;
//        _domainName.font =[UIFont systemFontOfSize:14];
//        _domainName.textColor =[UIColor redColor];
//        [_vcWebView insertSubview:_domainName belowSubview:_vcWebView.scrollView];
//    }
    
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    _vcWebView.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    [self loadBaidu];
    [self.navigationController.navigationBar addSubview:_webViewProgressView];
}


-(void)loadBaidu
{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_vcUrlString]];
    [_vcWebView loadRequest:req];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
    self.title = [_vcWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *domainStr = [_vcWebView stringByEvaluatingJavaScriptFromString:@"document.domain"];
    if (domainStr==nil||domainStr.length==0) {
        _vcWebView.domainLabel.alpha = 0.0;
    }else{
        _vcWebView.domainLabel.alpha = 1.0;
        _vcWebView.domainLabel.text =[NSString stringWithFormat:@"网页由 %@ 提供",domainStr];
    }
}

@end
