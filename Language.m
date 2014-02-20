//
//  Language.m
//  FotoFessor
//
//  Created by Stefan Brankovic on 13/11/13.
//  Copyright (c) 2013 EduLab. All rights reserved.
//

#import "Language.h"

@implementation Language

@synthesize language;
@synthesize first_time;


-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.language = [aDecoder decodeIntegerForKey:@"language"];
        self.first_time = [aDecoder decodeIntegerForKey:@"first_time"];
            }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:language forKey:@"language"];
    [encoder encodeInteger:first_time forKey:@"first_time"];
}



@end
