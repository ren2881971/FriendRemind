//
//  FriendCellTableViewCell.h
//  FriendRemind
//
//  Created by renfrank on 15/7/19.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *howLongWithNowTime;

@end
