//
//  FriendListTableViewController.m
//  FriendRemind
//
//  Created by renfrank on 15/7/9.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import "FriendListTableViewController.h"
#import "FriendInfoViewController.h"
#import "FriendStore.h"
#import "FriendCellTableViewCell.h"
#import "Friend.h"
#import "NSDateComponents+FRDateComponents.h"
#import "FriendDetialInfoViewController.h"
#import "BirthDayUtil.h"
@import CoreData;
@interface FriendListTableViewController ()<UITableViewDelegate>
@property(nonatomic,strong) NSMutableArray *friendList;
@property(nonatomic,weak) NSManagedObjectContext *context;/**< 上下文*/
@end

@implementation FriendListTableViewController


#pragma mark - Controller self method

-(instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"生日信息";
        UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNew:)];
        navItem.leftBarButtonItem =addItem;
        navItem.rightBarButtonItem = self.editButtonItem;
        FriendStore *store = [FriendStore sharedStore];
        self.context = store.managedObjectContext;
        
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"FriendCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FirendCell"];
    // 加载列表信息
    [self loadAllFriend];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loadAllFriend];
    //刷新tableview reloadData 需要主程执行。
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.friendList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirendCell" forIndexPath:indexPath];
    Friend *friend = self.friendList[indexPath.row];
    cell.nameLabel.text = friend.name;
    cell.birthdayLabel.text = friend.birthday;
    if (friend.friendImg != nil) {
        UIImage *shortImg = [UIImage imageWithData:friend.friendImg];
        cell.picImageView.image = shortImg;
        cell.picImageView.layer.masksToBounds = YES;
        cell.picImageView.layer.cornerRadius = cell.picImageView.bounds.size.width * 0.3;
        cell.picImageView.layer.borderWidth = 0.1;
        cell.picImageView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    NSString *birthDay = friend.birthday;
    NSString *howLongDay = [self howlongFromDate:birthDay];
    cell.howLongWithNowTime.text = [NSString stringWithFormat:@"距离生日还有%@天",howLongDay ];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static FriendCellTableViewCell *cell = nil;
    if (!nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FirendCell"];
    }
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    height = height + 1;
    NSLog(@"**************the cell height is %f",height);
    return height;
    
}

#pragma mark - operation method

-(IBAction)addNew:(id)sender
{
    FriendInfoViewController *infoView = [[FriendInfoViewController alloc] init];
    [self.navigationController pushViewController:infoView animated:YES];
    
}

- (void) loadAllFriend
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:self.context];
    
    NSError *error = nil;
    
    self.friendList = [[self.context executeFetchRequest:request error:&error] mutableCopy];
    if (error) {
        [NSException raise:@"加载列表信息错误" format:@"%@",[error localizedDescription]];
    }
    
}
/**< 计算现在时间距离生日时间还剩多少天 */
- (NSString *) howlongFromDate:(NSString *)fromDate
{
    BirthDayUtil *util = [BirthDayUtil new];
    return [util howlongFromDate:fromDate];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Friend *friend = self.friendList[indexPath.row];
        
        FriendStore *store = [FriendStore sharedStore];
        NSManagedObjectContext *context = store.managedObjectContext;
        
        [context deleteObject:friend];
        //NSManagedObjectContext 的所有  删除 修改 新增操作 都要save 才行。 不然都是临时的。
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            NSLog(@"could't delete the data !");
            abort();
        }else{
            [self.friendList removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    FriendDetialInfoViewController *detialInfoViewController = [[FriendDetialInfoViewController alloc] init];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    detialInfoViewController.friend = self.friendList[indexPath.row];
    [self.navigationController pushViewController:detialInfoViewController animated:YES];
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
