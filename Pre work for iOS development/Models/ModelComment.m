//
//  ModelComment.m
//  Bhavesh Lathigara -PreWork –Web
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import "ModelComment.h"

@implementation ModelComment
@synthesize comment,datetime;
-(id)init
{
    if (self = [super init])
    {
        comment = @"";
        datetime = 0;
    }
    return self;
}
@end
