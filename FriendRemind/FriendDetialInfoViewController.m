//
//  FriendDetialInfoViewController.m
//  FriendRemind
//
//  Created by renfrank on 15/7/21.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import "FriendDetialInfoViewController.h"

@interface FriendDetialInfoViewController ()

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *birthdayLabel;
@end

@implementation FriendDetialInfoViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _nameLabel = [[UILabel alloc] init];
        _birthdayLabel = [[UILabel alloc] init];
    }
    return self;
}

-(void)loadView
{
    UIView *view = [[UIView alloc] init];
    
    self.view = view;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    
    [self.view addSubview:self.nameLabel];
    
    [self.view addSubview:self.birthdayLabel];
    
    NSDictionary *dicView = @{@"imageView":self.imageView};
    
    /*This is imageView constraints.*/
    NSArray *widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(100)]" options:0 metrics:nil views:dicView];
    
    NSArray *heightConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(100)]" options:0 metrics:nil views:dicView];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:widthConstraint];
    
    [self.view addConstraints:heightConstraint];
    
    //垂直居中
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    
    //水平居中
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    /*This is nameLabel autolayout constraints*/
    NSArray *nameLabelVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView]-30-[nameLabel]" options:0 metrics:nil views:@{@"imageView":self.imageView,@"nameLabel":self.nameLabel}];
    
    
    NSLayoutConstraint *nameLabelHConstraints = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:nameLabelVConstraints];
    
    [self.view addConstraint:nameLabelHConstraints];
    /*This is birthdayLabel autolayout constrains*/
    NSArray *birthdayLabelVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nameLabel]-20-[birthdayLabel]" options:0 metrics:nil views:@{@"nameLabel":self.nameLabel,@"birthdayLabel":self.birthdayLabel}];
    
    NSLayoutConstraint *birthdayLabelHConstraints = [NSLayoutConstraint constraintWithItem:self.birthdayLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    self.birthdayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:birthdayLabelHConstraints];
    
    [self.view addConstraints:birthdayLabelVConstraints];
    
    
    /*
    [self.view addSubview:self.birthdayLabel];
     */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"详细信息";
    self.imageView.image = [[UIImage alloc] initWithData:self.friend.friendImg];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = self.imageView.bounds.size.width * 0.5;
    self.imageView.layer.borderWidth = 0.5;
    self.imageView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.nameLabel.text = self.friend.name;
    
    self.birthdayLabel.text = self.friend.birthday;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
