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
@import CoreData;
@interface FriendListTableViewController ()
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
        navItem.title = @"友情列表";
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
    NSString *birthDay = friend.birthday;
    NSDate *now = [NSDate date];
    NSLog(@"%@",[self howlongFromDate:birthDay]);
    return cell;
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

- (NSString *) howlongFromDate:(NSString *)fromDate
{
    //处理fromDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //中国东八时区
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    NSDate *fromDateObj = [dateFormatter dateFromString:fromDate];
    //处理当前时间
    NSDate *date = [NSDate date];
    
    NSDate *localeDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
    
    NSDateComponents *fromDateCom = [self getDateComponents:fromDateObj];
    
    NSDateComponents *localDateCom = [self getDateComponents:localeDate];

    //比较 NSDateComponents 的 月 和 日 大小。
    
    BOOL big = [NSDateComponents compare:fromDateCom big:localDateCom];
    
    if (big) {
       
    }else{
        
    }
     return @"";
    
}

-(NSDateComponents *) getDateComponents:(NSDate *) date
{
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    
    NSDateComponents *calComponts = [calendar components:unitFlags fromDate:date];
    
    return calComponts;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
