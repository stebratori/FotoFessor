//
//  ImageUploader.m
//  FotoFessor
//
//  Created by Stefan Brankovic on 13/11/13.
//  Copyright (c) 2013 EduLab. All rights reserved.
//

#import "ImageUploader.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


@implementation ImageUploader


- (void) uploadAnImage:(UIImage*)image withCode:(NSString*)code
{
    
    // api.fessor.da.thor.office/photo
    //api.matematikfessor.dk/photo
    NSString* finalUrl = [NSString stringWithFormat:@"http://api.fessor.da.thor.office/photo/upload_with_code/%@",code];
    NSURL *url = [NSURL URLWithString:finalUrl];

    NSData *imageData = UIImageJPEGRepresentation(image, 90);

    NSString* fileName = [NSString stringWithFormat:@"%@.jpeg",code];
    
    ASIFormDataRequest *asiRequest = [ASIFormDataRequest requestWithURL:url];
    [asiRequest addData:imageData withFileName:fileName andContentType:@"image/jpeg" forKey:@"data[Document][submittedfile]"];
    
    [asiRequest startAsynchronous];

    


}



@end
