//
//  FriendStore.h
//  FriendRemind
//
//  Created by renfrank on 15/7/19.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;
@interface FriendStore : NSObject
//factory method can get the friendStore share instance
+ (instancetype) sharedStore;
@property(nonatomic,strong,readonly) NSManagedObjectContext *managedObjectContext;
@end
