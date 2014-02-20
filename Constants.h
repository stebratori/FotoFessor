//
//  Constants.h
//  FotoFessor
//
//  Created by Stefan Brankovic on 13/11/13.
//  Copyright (c) 2013 EduLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject


@property (nonatomic,strong) NSString* danishOne;
@property (nonatomic,strong) NSString* danishTwo;
@property (nonatomic,strong) NSString* danishThree;
@property (nonatomic,strong) NSString* danishFour;
@property (nonatomic,strong) NSString* danishFive;
@property (nonatomic,strong) NSString* danishSix;
@property (nonatomic,strong) NSString* danishSeven;

@property (nonatomic,strong) NSString* norgeOne;
@property (nonatomic,strong) NSString* norgeTwo;
@property (nonatomic,strong) NSString* norgeThree;
@property (nonatomic,strong) NSString* norgeFour;
@property (nonatomic,strong) NSString* norgeFive;
@property (nonatomic,strong) NSString* norgeSix;
@property (nonatomic,strong) NSString* norgeSeven;

@property(nonatomic,assign) int language;

+ (Constants*)shared;


typedef enum{
    DANSK,
    NORGE
    
}languages;

@property (nonatomic,strong) NSString* danskServer;
@property (nonatomic,strong) NSString* norgeServer;

@property (nonatomic,strong) NSString* daLabel1;
@property (nonatomic,strong) NSString* daLabel2;

@property (nonatomic,strong) NSString* noLabel1;
@property (nonatomic,strong) NSString* noLabel2;

@end
