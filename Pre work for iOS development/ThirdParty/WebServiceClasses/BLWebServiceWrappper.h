//
//  BLWebServiceWrappper.h
//
//  Created by Bhavesh Lathigara on 7/15/15.
//  Copyright (c) 2015 Bhavesh Lathigara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLWebServiceWrappper : NSObject
+(void)callAPIWithParameters:(NSDictionary *)dict withURL:(NSString *)strurl Image:(UIImage *)image AndImageKey:(NSString *)imageKey ShowProgressInView:(UIView *)view isNeedToDisplayProgress:(BOOL)isProgress isPostCall:(BOOL)isPost isStringResponse:(BOOL)isString isNeedToSetBaseURL:(BOOL)isBaseURL success:(void(^)(id dict))successBlock failure:(void (^)(NSString *error))failureBlock;
@end
