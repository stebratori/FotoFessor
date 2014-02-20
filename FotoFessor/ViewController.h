//
//  ViewController.h
//  FotoFessor
//
//  Created by Stefan Brankovic on 12/11/13.
//  Copyright (c) 2013 EduLab. All rights reserved.
//
#import "ImageUploader.h"
#import "Constants.h"
#import "Language.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController  <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
}

- (void)checkWiFiConn;

@property (retain, nonatomic) IBOutlet UIImageView *appLogo;

@property (strong, atomic) NSString* code;
@property (strong, atomic) UIImage* takenPicture;

@property (strong, nonatomic) IBOutlet UIImageView *imageImage;
@property (strong, nonatomic) IBOutlet UIButton *oploadPhotoBtn;
@property (strong, nonatomic) IBOutlet UITextField *codeTxt;

-(IBAction)takeAPhoto:(UIButton*)sender;

@property (strong, nonatomic) IBOutlet UILabel *invalideCodeMessage;


@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UILabel *label2;

@property (strong, atomic) NSString* noInternetConnectionTitle;
@property (strong, atomic) NSString* noInternetConnectionMessage;

@property BOOL internet;
@property int firstTime;
@end
