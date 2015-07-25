//
//  Friend.m
//  FriendRemind
//
//  Created by renfrank on 15/7/19.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import "Friend.h"


@implementation Friend

@dynamic name;
@dynamic birthday;
@dynamic keyId;
@dynamic friendImg;
//when insert to the db,this method will be called.
-(void) awakeFromInsert
{
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    self.keyId = key;
}

@end
