//
//  AddWaterViewController.m
//  VCWeb
//
//  Created by VcaiTech on 16/7/7.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "AddWaterViewController.h"

@interface AddWaterViewController ()
{
    CGFloat a;
    CGFloat b;
    CGFloat z;
    CGFloat ta;
    CGFloat tb;
    CGFloat totalWater;
    NSTimer *timer;
    UIView *aZhu;
    UIView *bZhu;
    UIView *zZhu;
    CGFloat bottomPointY;
    
    NSInteger countTime;
    
    UILabel *aLabel;
    UILabel *bLabel;
    
    UILabel *pLabel;
    UIView  *pView;
}
@end

@implementation AddWaterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"5L6L桶量出3L水";
    self.view.backgroundColor =[UIColor whiteColor];
    countTime = 0;
    bottomPointY = 200;
    a = 0;
    b = 0;
    z = 30;
    ta = 50;
    tb = 60;
    
    aZhu =[[UIView alloc]initWithFrame:CGRectMake(10, bottomPointY-a, 20, a)];
    aZhu.backgroundColor =[UIColor redColor];
    [self.view addSubview:aZhu];
    aLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, bottomPointY, 40, 20)];
    aLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:aLabel];
    bZhu =[[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-20)*0.5, bottomPointY-b, 20, b)];
    bZhu.backgroundColor =[UIColor redColor];
    [self.view addSubview:bZhu];
    bLabel =[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-40)*0.5, bottomPointY, 40, 20)];
    bLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bLabel];
    
    pView =[[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)*0.5, bottomPointY+200-totalWater, 50, totalWater)];
    pView.backgroundColor =[UIColor blueColor];
    [self.view addSubview:pView];
    pLabel =[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-40)*0.5, bottomPointY+200, 40, 20)];
    pLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:pLabel];
    pLabel.text = [NSString stringWithFormat:@"%.0f",totalWater];
    
    UIView *cZhu =[[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-30), bottomPointY-z, 20, z)];
    cZhu.backgroundColor =[UIColor yellowColor];
    [self.view addSubview:cZhu];
   UILabel *cLabel =[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-40), bottomPointY, 40, 20)];
    cLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cLabel];
    cLabel.text = [NSString stringWithFormat:@"%.0f",z];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(daoshui) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

-(void)daoshui{
    if (a != z) {
        if(a == 0) {
            a = ta;
            countTime++;
            [aZhu setFrame:CGRectMake(10, bottomPointY-a, 20, a)];
        }
        
        if(a + b > tb) {
            int temp = tb - b;
            if (temp!=0) {
                b = tb;
                
            }else{
                totalWater+=b;
                b = 0;
                [pView setFrame:CGRectMake((self.view.frame.size.width-50)*0.5, bottomPointY+200-totalWater, 50, totalWater)];
                 pLabel.text = [NSString stringWithFormat:@"%.0f",totalWater];
            }
            a = a - temp;
            [aZhu setFrame:CGRectMake(10, bottomPointY-a, 20, a)];
            [bZhu setFrame:CGRectMake((self.view.frame.size.width-20)*0.5, bottomPointY-b, 20, b)];
            bLabel.text = [NSString stringWithFormat:@"%.0f",b];
            aLabel.text = [NSString stringWithFormat:@"%.0f",a];
        } else {
            b = b + a;
            a = 0;
            [aZhu setFrame:CGRectMake(10, bottomPointY-a, 20, a)];
            [bZhu setFrame:CGRectMake((self.view.frame.size.width-20)*0.5, bottomPointY-b, 20, b)];
            bLabel.text = [NSString stringWithFormat:@"%.0f",b];
            aLabel.text = [NSString stringWithFormat:@"%.0f",a];
        }
        
    }else{
        NSLog(@"%ld",countTime);
        [timer invalidate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
