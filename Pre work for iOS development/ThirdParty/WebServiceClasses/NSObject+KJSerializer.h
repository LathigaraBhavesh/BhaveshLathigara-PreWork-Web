//
//  KJObjectSerializer.h
//  KJObjectSerialize
//
//  Created by Bhavesh Lathigara on 6/20/2010.
//  Copyright (c) 2010 Bhavesh Lathigara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KJObjectSerializer)

-(NSMutableDictionary *)getDictionary;
-(void)setDictionary:(NSDictionary*)dictionary;

@end
