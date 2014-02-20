//
//  HelpViewController.h
//  FotoFessor
//
//  Created by Stefan Brankovic on 13/11/13.
//  Copyright (c) 2013 EduLab. All rights reserved.
//

#import "ViewController.h"

@interface HelpViewController : ViewController

@property (retain, nonatomic) IBOutlet UILabel *txt1;
@property (retain, nonatomic) IBOutlet UILabel *txt2;
@property (retain, nonatomic) IBOutlet UILabel *txt3;
@property (retain, nonatomic) IBOutlet UILabel *txt4;
@property (retain, nonatomic) IBOutlet UILabel *txt5;
@property (retain, nonatomic) IBOutlet UILabel *txt6;
@property (retain, nonatomic) IBOutlet UILabel *txt7;

-(IBAction)changeLanguage:(UIButton*)sender;


@property (retain, nonatomic) IBOutlet UIButton *languageBtn;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;


@end
