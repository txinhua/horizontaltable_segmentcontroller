//
//  ViewController.m
//  VCWeb
//
//  Created by VcaiTech on 16/6/27.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "ViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import <MJRefresh/MJRefresh.h>
#import "VCWebBrowserController.h"
#import "ServerEntity.h"
#import "SignatureUtils.h"
#import "VCNetRequestBaseService.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    HMSegmentedControl *segmentedControl4;
    BOOL isClickedChange;
}
@property(nonatomic,retain)UITableView *horizontalTable;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _horizontalTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _horizontalTable.delegate = self;
    _horizontalTable.dataSource = self;
    _horizontalTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _horizontalTable.scrollsToTop = NO;
    _horizontalTable.transform = CGAffineTransformMakeRotation(-M_PI_2);
    _horizontalTable.showsVerticalScrollIndicator = NO;
    _horizontalTable.pagingEnabled = YES;
    _horizontalTable.bounces = NO;
    [_horizontalTable setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:_horizontalTable];
    
    segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(40, 20,self.view.frame.size.width-80 , 44)];
    segmentedControl4.sectionTitles = @[@"red", @"green"];
    segmentedControl4.selectedSegmentIndex = 0;
    segmentedControl4.backgroundColor = [UIColor whiteColor];
    segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1]};
    segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
    segmentedControl4.selectionIndicatorColor = [UIColor redColor];
    segmentedControl4.selectionIndicatorBoxOpacity = 0;
    segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl4.tag = 3;
    __weak ViewController *weak_self = self;
    [segmentedControl4 setIndexChangeBlock:^(NSInteger index) {
        isClickedChange = YES;
        [weak_self.horizontalTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }];
    [self.view addSubview:segmentedControl4];
    
    UIButton *browserBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [browserBtn setTitle:@"br" forState:UIControlStateNormal];
    [browserBtn setFrame:CGRectMake(self.view.frame.size.width-35, 27, 30, 30)];
    [self.view addSubview:browserBtn];
    [browserBtn addTarget:self action:@selector(showBrowserView) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_horizontalTable]) {
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"hcell"];
        
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hcell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.transform = CGAffineTransformMakeRotation(M_PI_2);
            UITableView *contentTable =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, _horizontalTable.frame.size.width, _horizontalTable.frame.size.height) style:UITableViewStylePlain];
            contentTable.tag = 10010;
            contentTable.delegate = self;
            contentTable.dataSource = self;
            [cell.contentView addSubview:contentTable];
            // Set the callback（一Once you enter the refresh status，then call the action of target，that is call [self loadNewData]）
            NSArray *idleImages =@[[UIImage imageNamed:@"loading_1"]];
            NSArray *refreshingImages =@[[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"],[UIImage imageNamed:@"loading_3"],[UIImage imageNamed:@"loading_4"],[UIImage imageNamed:@"loading_5"],[UIImage imageNamed:@"loading_6"]];
//            __weak ViewController *weak_self = self;
            MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
                
                NSInteger typeIndex = segmentedControl4.selectedSegmentIndex;
                //获取该类型的网络请求
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [contentTable.mj_header endRefreshing];
                });
            }];
            // Set the ordinary state of animated images
            [header setImages:idleImages forState:MJRefreshStateIdle];
            // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
            [header setImages:idleImages forState:MJRefreshStatePulling];
            // Set the refreshing state of animated images
            [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
            // Hide the time
            header.lastUpdatedTimeLabel.hidden = YES;
            
            // Hide the status
            header.stateLabel.hidden = YES;
            // Set header
            contentTable.mj_header = header;
            
        }
        return cell;
    }else{
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"vcell"];
        
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"vcell"];
        }
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:_horizontalTable]) {
        return self.view.frame.size.width;
    }else{
        return 50;
    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_horizontalTable]) {
       return 2;
    }else{
        return 0;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_horizontalTable]&&!isClickedChange) {
        NSIndexPath *indexPath = [[_horizontalTable indexPathsForVisibleRows] lastObject];
        [segmentedControl4 setSelectedSegmentIndex:indexPath.row animated:YES];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    isClickedChange = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showBrowserView{
    
    
//    NSDictionary *parameDic = @{@"cc":@"0086",@"phone":@"18015133059",@"smscode":@"1235"};
//    ServerEntity *server = [[ServerEntity alloc]initWithMethod:@"POST" andUrl:@"/user/login"];
//    [SignatureUtils clearAccessToken];
//    [[[VCNetRequestBaseService alloc]init]requestDataFromServer:server.serverUrl  withMethod:server.requestMethod Parame:parameDic andCompletion:^(ResponsedUnit *responseUnit, NSError *error) {
//        if (!error) {
//            if (responseUnit) {
//                
//            }else{
//                NSLog(@"返回值错误");
//            }
//        }
//        
//    }];
    
    
//    NSDictionary *parameDic = @{@"username":@"18015133059",@"act":@"w7P5L1JXDvMRQdr9YOgyeXRsWU1Jdoz5X7Cb8BblKBxEZGpazWAn2o3bjqN8"};
//    ServerEntity *server = [[ServerEntity alloc]initWithMethod:@"POST" andUrl:@"/user/login"];
//    [SignatureUtils clearAccessToken];
//    [[[VCNetRequestBaseService alloc]init]requestDataFromServer:server.serverUrl  withMethod:server.requestMethod Parame:parameDic andCompletion:^(ResponsedUnit *responseUnit, NSError *error) {
//        if (!error) {
//            if (responseUnit) {
//
//            }else{
//                NSLog(@"返回值错误");
//            }
//        }
//        
//    }];
    
    
    
    VCWebBrowserController *vcBrowser =[[VCWebBrowserController alloc]init];
    vcBrowser.vcUrlString = @"http://www.baidu.com";
    [self.navigationController pushViewController:vcBrowser animated:YES];
    
}



@end
