//
//  Constants.m
//  FotoFessor
//
//  Created by Stefan Brankovic on 13/11/13.
//  Copyright (c) 2013 EduLab. All rights reserved.
//

#import "Constants.h"

@implementation Constants

static Constants *constants = nil;


+ (Constants*)shared {
    
    if (nil == constants) {
        
        if (constants == nil) {
            constants = [[[self class]alloc] init];
        }
        
        
    }
    return constants;
}
@end
