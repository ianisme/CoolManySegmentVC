//
//  RootViewController.m
//  CoolManySegmentVC
//
//  Created by ian on 2017/8/7.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "RootViewController.h"
#import "CoolManySegmentBaseViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CoolManySegmentVC";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushAction:(id)sender {
    
    CoolManySegmentBaseViewController *controller = [[CoolManySegmentBaseViewController alloc] init];
    
    FirstViewController *one = [[FirstViewController alloc] init];
    SecondViewController *two = [[SecondViewController alloc] init];
    [controller configTitles:@[@"test1", @"testtesttest2"] controllers:@[one, two]];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
