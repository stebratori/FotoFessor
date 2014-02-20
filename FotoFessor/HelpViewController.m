//
//  HelpViewController.m
//  FotoFessor
//
//  Created by Stefan Brankovic on 13/11/13.
//  Copyright (c) 2013 EduLab. All rights reserved.
//

#import "HelpViewController.h"
#import "Constants.h"
#import "Language.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

-(void)viewDidAppear:(BOOL)animated
{
    _scrollView.contentSize=CGSizeMake(320,1000);
    _scrollView.scrollEnabled=YES;
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self setLanguage];
    [self setUpAScrollView];
}

-(void)setUpAScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1350)];
    
}

-(IBAction)changeLanguage:(UIButton *)sender
{
    switch ([Constants shared].language) {
            
        case DANSK:
            [Constants shared].language = NORGE;
            break;
            
        case NORGE:
            [Constants shared].language = DANSK;
            break;
    }
    [self setLanguage];
    
    Language* language = [[Language alloc]init];
    language.language = [Constants shared].language;
    language.first_time = 123;
    
    NSMutableArray *languagesArray = [[NSMutableArray alloc]init];
    
    [languagesArray addObject:language];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:languagesArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"settings"];
}

-(void)setLanguage
{
    switch ([Constants shared].language) {
        
        case DANSK:
            _txt1.text=[Constants shared].danishOne;
            _txt2.text=[Constants shared].danishTwo;
            _txt3.text=[Constants shared].danishThree;
            _txt4.text=[Constants shared].danishFour;
            _txt5.text=[Constants shared].danishFive;
            _txt6.text=[Constants shared].danishSix;
            _txt7.text=[Constants shared].danishSeven;
            [_languageBtn setTitle:@"Da" forState:UIControlStateNormal];
            
            break;
            
        case NORGE:
            _txt1.text=[Constants shared].norgeOne;
            _txt2.text=[Constants shared].norgeTwo;
            _txt3.text=[Constants shared].norgeThree;
            _txt4.text=[Constants shared].norgeFour;
            _txt5.text=[Constants shared].norgeFive;
            _txt6.text=[Constants shared].norgeSix;
            _txt7.text=[Constants shared].norgeSeven;
            [_languageBtn setTitle:@"No" forState:UIControlStateNormal];

            break;
    }
}

- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}









@end
