//
//  ModelImage.m
//  Bhavesh Lathigara -PreWork –Web
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import "ModelImage.h"

@implementation ModelImage
@synthesize title,link,datetime,comments;
-(id)init
{
    if (self = [super init])
    {
        title = @"";
        link = @"";
        datetime = @"";
        comments = nil;
    }
    return self;
}
@end
