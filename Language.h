//
//  Language.h
//  FotoFessor
//
//  Created by Stefan Brankovic on 13/11/13.
//  Copyright (c) 2013 EduLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject <NSCoding>{
    
    int language;
    int first_time;
    NSString* server;
}
@property (nonatomic, assign) int language;
@property (nonatomic, assign) int first_time;


@end
