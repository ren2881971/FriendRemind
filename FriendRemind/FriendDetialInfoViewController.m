//
//  FriendDetialInfoViewController.m
//  FriendRemind
//
//  Created by renfrank on 15/7/21.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import "FriendDetialInfoViewController.h"

@interface FriendDetialInfoViewController ()

@end

@implementation FriendDetialInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"详细信息";
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
