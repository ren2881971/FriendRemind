//
//  FriendInfoViewController.m
//  FriendRemind
//
//  Created by renfrank on 15/7/19.
//  Copyright (c) 2015年 frank. All rights reserved.
//

#import "FriendInfoViewController.h"
#import "FriendStore.h"
@import CoreData;
@interface FriendInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak,nonatomic) IBOutlet UITextField *birthDayText;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *confrimButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@end

@implementation FriendInfoViewController

-(instancetype) init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.toolBar setItems:@[self.confrimButton,self.cancelButton] animated:YES];
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.birthDayText setInputView:self.datePicker];
    
    [self.birthDayText setInputAccessoryView:self.toolBar];
    
    self.navigationItem.title = @"添加朋友生日";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveFriend:)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
}


- (IBAction)confirmDate:(id)sender {
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [dateFormatter stringFromDate:date];
    self.birthDayText.text = dateStr;
    [self.birthDayText resignFirstResponder];
}

- (IBAction)cancelDate:(id)sender {
    [self.birthDayText resignFirstResponder];
    NSLog(@"cancel...");
}

-(void) saveFriend:(id)sender
{
    NSLog(@"%@,%@",self.nameText.text,self.birthDayText.text);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectDateInpuf:(id)sender {
    FriendStore *store = [FriendStore sharedStore];
    
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
