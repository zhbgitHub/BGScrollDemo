//
//  ViewController.m
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/28.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import "ViewController.h"
#import "JYReportBallView.h"
#import "JYReportBarView.h"
#import "JYBallProgressView.h"
#import "NSString+Category.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    JYReportBarView *subView = [[JYReportBarView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 235)];
    subView.barrelCount = 9;
    [self.view addSubview:subView];
    subView.percentArray = [self demoValues];
    
    JYBallProgressView *progressView = [[JYBallProgressView alloc] initWithFrame:CGRectMake(0, 300, 100, 100)];
    [self.view addSubview:progressView];
//    progressView.colors = @[[UIColor yellowColor], [UIColor redColor], [UIColor grayColor]];
    [progressView startAnimation];
    

    NSString *test1 = @"   fdafasf  fdasfadsfds fdsfdsfas fdsafdsa     addfds      \n fdsfdsf   \n  ";
    NSString *test2 = @"67890";
    NSString *test3 = @"67890.4567890";

    
    NSLog(@"str_leadAndTailSpace===%@", [NSString str_leadAndTailSpace:test1]);
    NSLog(@"str_deleteDedundantSpace===%@", [NSString str_deleteDedundantSpace:test1]);
    NSLog(@"str_deleteAllSpace===%@", [NSString str_deleteAllSpace:test1]);
    NSLog(@"currencyForma===%@", [NSString str_currencyFormat:test1]);
    NSLog(@"currencyForma===%@", [NSString str_currencyFormat:test2]);
    NSLog(@"currencyForma===%@", [NSString str_currencyFormat:test3]);
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)demoValues
{
    NSInteger count = 9;
    NSMutableArray *defaulValues = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i<count; i++) {
        [defaulValues addObject:@((float)arc4random_uniform(101)/100.f)];
    }
    return [defaulValues copy];
}


@end
