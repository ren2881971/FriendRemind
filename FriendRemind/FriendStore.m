//
//  FriendStore.m
//  FriendRemind
//
//  Created by renfrank on 15/7/19.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import "FriendStore.h"
@import CoreData;
@interface FriendStore ()

@property(nonatomic,strong) NSManagedObjectModel *managedObjectModel;
@property(nonatomic,strong,readwrite) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong) NSPersistentStoreCoordinator *persistenStoreCoordinator;
@end

@implementation FriendStore


+ (instancetype)sharedStore
{
    static FriendStore *store = nil;
    if (!store) {
        store = [[self alloc] initPrivate];
    }
    return store;

}
// public init when call this method will throw exception .
-(instancetype) init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"use + [FriendStore sharedStore]" userInfo:nil];
    return nil;
}
//private init method.
-(instancetype) initPrivate
{
    self = [super init];
    if (self) {
        //init the core Data
        
    }
    return self;
}

-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistenStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

-(NSPersistentStoreCoordinator *)persistenStoreCoordinator
{
    if (_persistenStoreCoordinator != nil) {
        return _persistenStoreCoordinator;
    }
    //by default the name of the store on disk is the same as the name of the project
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FriendRedmind.sqlite"];
    
    NSError *error = nil;
    
    _persistenStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistenStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@,%@",error,[error userInfo]);
        abort();
    }
    return _persistenStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


// returns the URL to the application's Documents directory
-(NSURL *) applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

















@end
