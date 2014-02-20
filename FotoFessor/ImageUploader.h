//
//  ImageUploader.h
//  FotoFessor
//
//  Created by Stefan Brankovic on 13/11/13.
//  Copyright (c) 2013 EduLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUploader : NSObject

- (void) uploadAnImage:(UIImage*)image withCode:(NSString*)code;

@end
