//
//  NSObject+FRDateComponents.h
//  FriendRemind
//
//  Created by renfrank on 15/7/20.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateComponents (FRDateComponents)
+ (BOOL) compare:(NSDateComponents *) oneComponents big:(NSDateComponents *) otherComponents;
@end
