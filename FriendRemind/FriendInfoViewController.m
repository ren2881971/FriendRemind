//
//  FriendInfoViewController.m
//  FriendRemind
//
//  Created by renfrank on 15/7/19.
//  Copyright (c) 2015年 frank. All rights reserved.
//  添加 friend info page.
//

#import "FriendInfoViewController.h"
#import "FriendStore.h"
#import <MobileCoreServices/MobileCoreServices.h>
@import CoreData;


@interface FriendInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak,nonatomic) IBOutlet UITextField *birthDayText;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *confrimButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *friendPic;
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
     UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [self.toolBar setItems:@[flexSpace,self.confrimButton,flexSpace,self.cancelButton,flexSpace] animated:YES];
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.birthDayText setInputView:self.datePicker];
    
    [self.birthDayText setInputAccessoryView:self.toolBar];
    
    self.navigationItem.title = @"添加朋友生日";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveFriend:)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    //image view handle.
    if (!self.friendPic.image) {
        UIImage *image = [UIImage imageNamed:@"one.jpg"];
        self.friendPic.image = image;
        self.friendPic.layer.masksToBounds = YES;
        self.friendPic.layer.cornerRadius = self.friendPic.bounds.size.width * 0.1;
        
        self.friendPic.layer.borderWidth = 0.5;
        
        self.friendPic.layer.borderColor = [UIColor grayColor].CGColor;
    }
    //这个属性 会屏蔽 user event  比如 touch
    self.friendPic.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePic:)];
    singleTap.numberOfTapsRequired = 1;
    [self.friendPic addGestureRecognizer:singleTap];
    
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
    FriendStore *store = [FriendStore sharedStore];
    NSManagedObjectContext *context = store.managedObjectContext;
    NSManagedObject *friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:context];
    
    [friend setValue:self.nameText.text forKey:@"name"];
    [friend setValue:self.birthDayText.text forKey:@"birthday"];
    if (self.friendPic.image != nil) {
        NSData *imgData = UIImageJPEGRepresentation(self.friendPic.image,0.5);
        [friend setValue:imgData forKey:@"friendImg"];
    }else{
        UIImage *image = [UIImage imageNamed:@"one.jpg"];
        NSData *imgData = UIImagePNGRepresentation(image);
        [friend setValue:imgData forKey:@"friendImg"];
    }
    NSError *error = nil;
    if (![context save:&error]) {
        [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectDateInpuf:(id)sender {
    
}

//friendPic touch event
-(void) changePic:(UITapGestureRecognizer *) sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取",nil];
    [sheet showInView:self.view];
    NSLog(@"pic is touch.");
}
#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            
            [mediaTypes addObject:(__bridge NSString *) kUTTypeImage];
            
            imagePicker.mediaTypes = mediaTypes;
            
            imagePicker.delegate = self;
            
            [self presentViewController:imagePicker animated:YES completion:^(void){
                NSLog(@"Picker View Controller is presented");
                }
             ];
        }
        
    }else if(buttonIndex == 1){
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            
            [mediaTypes addObject:(__bridge NSString*) kUTTypeImage];
            
            imagePicker.mediaTypes = mediaTypes;
            
            imagePicker.delegate = self;
            
            //模态 显示照相机
            [self presentViewController:imagePicker animated:YES completion:^(void){
                NSLog(@"Picker View Controller is presented");
            }];
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma  mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *portraitImg = info[@"UIImagePickerControllerOriginalImage"];
    
    self.friendPic.image = portraitImg;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

-(BOOL) doesCameraSupportTakingPhotos
{
    //__bridge  CF CG to iOS
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

-(BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(BOOL) cameraSupportsMedia:(NSString *) paramMediaType sourceType: (UIImagePickerControllerSourceType) paramSourceType
{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

















@end
