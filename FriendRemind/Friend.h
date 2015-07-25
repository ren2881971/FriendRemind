//
//  Friend.h
//  FriendRemind
//
//  Created by renfrank on 15/7/19.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friend : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * birthday;
@property (nonatomic, retain) NSString * keyId;
@property (nonatomic,retain) NSData *friendImg;
@end
